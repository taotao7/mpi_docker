#!/usr/bin/sh
#
#
#root check
if [ $EUID -ne 0 ]; then
  echo "This script must be run as root (or with sudo)"
  exit 1
fi

#
if systemctl status nfs-kernel-server >/dev/null 2>&1; then

echo "输入nfs挂载主机的ip, 例如 192.168.10.8"
echo "当前脚本用的本机nfs服务所以请保证本机已经安装nfs server服务"
echo "如果在公网运行请输入公网ip"
read -r nfs_host 
export NFS_HOST="$nfs_host"
export NFS_DIR="$(pwd)/cloud"



echo "${NFS_DIR} *(rw,sync,no_subtree_check,no_root_squash,insecure)" > ./exports
cp ./exports /etc/exports
exportfs -a


#build dockerfile
docker build -t mpi .

#create manager host
docker run --privileged -itd --name manager mpi
# TODO 复制例子到docker manger主机
# TODO 输入ip和主机方便绑定ssh
# TODO 可以使用普通用户执行
# TODO 添加IP到hosts
# TODO 添加ssh-keygen到每个集群主机
# TODO 设置本机nfs共享
# TODO 执行需要带上docker run --privileged -itd --name cluster1 mpi






# ssh-keygen -t dsa

# docker build -t myimage .

# ssh-copy-id root@cluster1
else
  echo "nfs-kernel-server is not running"
fi

