#!/usr/bin/fish
test (id -u) -ne 0; and echo 'ERROR: please run script as superuser!'; and exit

# disable and delete 6lowpan interface
sudo ip link set wpan0 down
sudo ip link set lowpan0 down
sudo ip link delete dev lowpan0
echo 'DONE!'
