#!/usr/bin/sh
#
#

#root check
if [ $(id -u) -ne 0 ]; then
    echo "请使用 root 账户执行这个脚本"
    exit 1
fi

workdir=$(pwd)

# TODO 输入ip和主机方便绑定ssh
# TODO 可以使用普通用户执行
# TODO 添加IP到hosts
# TODO 添加ssh-keygen到每个集群主机

# TODO 设置本机nfs共享
echo "$workdir *(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports  
exportfs -arv 
systemctl enable nfs-server.service 
systemctl start nfs-server.service 
systemctl enable nfsv4-server.service 
systemctl start nfsv4-server.service 

#TODO执行需要带上docker run --privileged -itd --name cluster1 mpi

username=$(whoami)
echo $username





# ssh-keygen -t dsa

# docker build -t myimage .

# ssh-copy-id root@cluster1
