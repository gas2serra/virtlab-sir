#!/bin/sh
# custom VPN Client configuration for service (security.py)
# -------- CUSTOMIZATION REQUIRED --------
#
# The VPNClient service builds a VPN tunnel to the specified VPN server using
# OpenVPN software and a virtual TUN/TAP device.

# directory containing the certificate and key described below
certdir=$SESSION_DIR/certs
keydir=$PWD

# the name used for a "$keyname.pem" certificate and "$keyname.key" private key.
keyname=vpnclient

# the public IP address of the VPN server this client should connect with
vpnserver="10.0.1.10"

# optional next hop for adding a static route to reach the VPN server
nexthop=""

# --------- END CUSTOMIZATION --------

# validate addresses
if [ "$(dpkg -l | grep sipcalc)" = "" ]; then
    echo "WARNING: ip validation disabled because package sipcalc not installed 
         " > $PWD/vpnclient.log
else
    if [ "$(sipcalc "$vpnserver" "$nexthop" | grep ERR)" != "" ]; then
        echo "ERROR: invalide address $vpnserver or $nexthop \
             " > $PWD/vpnclient.log
    fi
fi

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

# if necessary, add a static route for reaching the VPN server IP via the IF
vpnservernet=${vpnserver%.*}.0/24
if [ "$nexthop" != "" ]; then
    /sbin/ip route add $vpnservernet via $nexthop
fi

# create openvpn client.conf
(
cat << EOF
client
dev tun
proto udp
remote $vpnserver 1194
nobind
ca $certdir/ca-cert.pem
cert $keydir/$keyname.pem
key $keydir/$keyname.key
dh $certdir/dh2048.pem
cipher AES-256-CBC
log /var/log/openvpn-client.log
verb 4
daemon
EOF
) > client.conf
    
openvpn --config client.conf

