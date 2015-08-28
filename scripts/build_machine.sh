#!/bin/bash
MACHINE=dev
CPUS=2
MEM=16392
DISK=10000

docker-machine create --driver virtualbox --virtualbox-cpu-count $CPUS --virtualbox-memory $MEM ---virtualbox-disk-size $DISK $MACHINE 

if [ `docker-machine ip dev` != 192.168.99.100 ]
then
  echo
  echo "Your docker-machine ip is set to `docker-machine ip dev` instead of 192.168.99.100"
  echo "This will conflict with Creative Server's default settings."
  echo
  echo "To get a box with the correct ip address, use 'docker-machine rm dev' and"
  echo "'VBoxManage hostonlyif remove vboxnet(n)' where (n) is the network adapter in"
  echo "VirtualBox."
  echo
fi

echo "Created new machine '$MACHINE' on `docker-machine ip dev`."