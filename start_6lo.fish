#!/usr/bin/fish
test (id -u) -ne 0; and echo 'ERROR: please run script as superuser!'; and exit

# config
test (count $argv) -ne 1; and echo 'ERROR: please provide the device id'; and exit
set ID $argv[1]
set PAN_ID '0xFEED'
set SHORT_ADDR '0x'$ID
set IPV6 'FEED::'$ID'/64'
echo "config: PAN_ID=$PAN_ID, SHORT_ADDR=$SHORT_ADDR, 6LOWPAN_IP=$IPV6"

# prepare wpan level
echo 'setting up 802.15.4...'
sudo ip link set wpan0 down
sudo iwpan dev wpan0 set pan_id $PAN_ID
sudo iwpan dev wpan0 set short_addr $SHORT_ADDR

# create associated 6lowpan on top of 802.15.4
echo 'setting up 6lowpan...'
sudo modprobe ieee802154_6lowpan
sudo ip link add link wpan0 name lowpan0 type lowpan
sudo ip addr add $IPV6 dev lowpan0

# go!
echo 'starting interfaces...'
sudo ip link set wpan0 up
sudo ip link set lowpan0 up
echo 'DONE!'
