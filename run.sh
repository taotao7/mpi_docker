#!/usr/bin/sh
#
#
mount -t nfs 192.168.10.8:${pwd} /root/cloud

docker run --privileged  -itd --name cluster1 mpi
