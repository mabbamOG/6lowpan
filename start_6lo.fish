# needed to handle the interface
sudo modprobe ieee802154_6lowpan

# prepare wpan level
sudo ip link set wpan0 down
sudo iwpan dev wpan0 set pan_id '0xbaad'

# create associated 6lowpan on top of 802.15.4
sudo ip link add link wpan0 name lowpan0 type lowpan

# go!
sudo ip link set wpan0 up
sudo ip link set lowpan0 up
