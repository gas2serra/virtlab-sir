# these
sudo ip link set eth1 down
sudo ip addr add 10.10.10.3/24 dev eth1
sudo ip link set eth1 up
sudo ip link add gt0 type gretap remote 10.10.10.2 local 10.10.10.3 key 1
sudo ip addr add 192.168.10.3/24 dev gt0
sudo ip link set dev gt0 up
sudo ip route add 192.168.0.0/16 via 192.168.10.1

