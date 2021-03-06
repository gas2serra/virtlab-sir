#!/bin/sh
# custom VPN Server Configuration for service (security.py)
# -------- CUSTOMIZATION REQUIRED --------
#
# The VPNServer service sets up the OpenVPN server for building VPN tunnels
# that allow access via TUN/TAP device to private networks.
#
# note that the IPForward and DefaultRoute services should be enabled

# directory containing the certificate and key described below, in addition to
# a CA certificate and DH key
certdir=$SESSION_DIR/certs
keydir=$PWD

# the name used for a "$keyname.pem" certificate and "$keyname.key" private key.
keyname=vpnserver

# the VPN subnet address from which the client VPN IP (for the TUN/TAP) 
# will be allocated
vpnsubnet=10.0.200.0

# public IP address of this vpn server (same as VPNClient vpnserver= setting)
vpnserver=10.0.1.10

# optional list of private subnets reachable behind this VPN server
# each subnet and next hop is separated by a space
# "<subnet1>,<nexthop1> <subnet2>,<nexthop2> ..."
privatenets="10.0.6.0,10.0.1.10"

# optional list of VPN clients, for statically assigning IP addresses to
# clients; also, an optional client subnet can be specified for adding static
# routes via the client
# Note: VPN addresses x.x.x.0-3 are reserved
# "<keyname>,<vpnIP>,<subnetIP> <keyname>,<vpnIP>,<subnetIP> ..."
#vpnclients="client1KeyFilename,10.0.200.5,10.0.0.0 client2KeyFilename,,"
vpnclients=""

# NOTE: you may need to enable the StaticRoutes service on nodes within the
# private subnet, in order to have routes back to the client.
# /sbin/ip ro add <vpnsubnet>/24 via <vpnServerRemoteInterface> 
# /sbin/ip ro add <vpnClientSubnet>/24 via <vpnServerRemoteInterface>

# -------- END CUSTOMIZATION --------

echo > $PWD/vpnserver.log
rm -f -r $PWD/ccd

# validate key and certification files
check-key-file() {
    if [ ! -e $1 ]; then
        echo "ERROR: missing certification or key file: $1" >> $PWD/vpnserver.log
    fi
}

check-key-file $keydir/$keyname.key
check-key-file $keydir/$keyname.pem
check-key-file $certdir/ca-cert.pem
check-key-file $certdir/dh2048.pem 

# validate configuration IP addresses
checkip=0
if [ "$(dpkg -l | grep sipcalc)" = "" ]; then
   echo "WARNING: ip validation disabled because package sipcalc not installed\
        " >> $PWD/vpnserver.log
   checkip=1
else
    if [ "$(sipcalc "$vpnsubnet" "$vpnserver" | grep ERR)" != "" ]; then
     echo "ERROR: invalid vpn subnet or server address \
$vpnsubnet or $vpnserver " >> $PWD/vpnserver.log
    fi
fi
 
# create client vpn ip pool file
(
cat << EOF
EOF
)> $PWD/ippool.txt

# create server.conf file
(
cat << EOF
# openvpn server config
local $vpnserver
server $vpnsubnet 255.255.255.0
push redirect-gateway def1
EOF
)> $PWD/server.conf

# add routes to VPN server private subnets, and push these routes to clients
for privatenet in $privatenets; do
    if [ $privatenet != "" ]; then
        net=${privatenet%%,*}
        nexthop=${privatenet##*,}
        if [ $checkip = "0" ] &&
           [ "$(sipcalc "$net" "$nexthop" | grep ERR)" != "" ]; then
            echo "ERROR: invalid vpn server private net address \
$net or $nexthop " >> $PWD/vpnserver.log
	fi
        echo push route $net 255.255.255.0 >> $PWD/server.conf
    fi
done

# allow subnet through this VPN, one route for each client subnet
for client in $vpnclients; do
    if [ $client != "" ]; then
        cSubnetIP=${client##*,}
        cVpnIP=${client#*,}
        cVpnIP=${cVpnIP%%,*}
        cKeyFilename=${client%%,*}
        if [ "$cSubnetIP" != "" ]; then
            if [ $checkip = "0" ] &&
               [ "$(sipcalc "$cSubnetIP" "$cVpnIP" | grep ERR)" != "" ]; then
                echo "ERROR: invalid vpn client and subnet address \
$cSubnetIP or $cVpnIP " >> $PWD/vpnserver.log
	    fi
            echo route $cSubnetIP 255.255.255.0  >> $PWD/server.conf
            if ! test -d $PWD/ccd; then
                mkdir -p $PWD/ccd
                echo  client-config-dir $PWD/ccd >> $PWD/server.conf
            fi
            if test -e $PWD/ccd/$cKeyFilename; then
              echo iroute $cSubnetIP 255.255.255.0 >> $PWD/ccd/$cKeyFilename
            else
              echo iroute $cSubnetIP 255.255.255.0 > $PWD/ccd/$cKeyFilename
            fi
        fi
        if [ "$cVpnIP" != "" ]; then
            echo $cKeyFilename,$cVpnIP >> $PWD/ippool.txt
        fi
    fi
done

(
cat << EOF
keepalive 10 120
ca $certdir/ca-cert.pem
cert $keydir/$keyname.pem
key $keydir/$keyname.key
dh $certdir/dh2048.pem
cipher AES-256-CBC
status /var/log/openvpn-status.log
log /var/log/openvpn-server.log
ifconfig-pool-linear
ifconfig-pool-persist $PWD/ippool.txt
port 1194
proto udp
dev tun
verb 4
daemon
EOF
)>> $PWD/server.conf

# start vpn server
openvpn --config server.conf

