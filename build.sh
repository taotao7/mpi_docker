#!/usr/bin/sh
#
#
#root check
if [ $EUID -ne 0 ]; then
  echo "请用root或者sudo"
  exit 1
fi

#

# if ! systemctl is-active --quiet nfs-kernel-server; then
#   echo "NFS服务未安装或未启动"
#   exit 1
# fi

echo "输入nfs挂载主机的ip, 例如 192.168.10.8"
echo "当前脚本用的本机nfs服务所以请保证本机已经安装nfs server服务"
echo "如果在公网运行请输入公网ip"
read -r nfs_host 
export NFS_HOST="$nfs_host"
export NFS_DIR="$(pwd)/cloud"





echo "输入节点数量"
read -r node_num 



echo "${NFS_DIR} *(rw,sync,no_subtree_check,no_root_squash,insecure)" > ./exports
cp ./exports /etc/exports
exportfs -a


#构建 dockerfile
docker build -t mpi . 

#创建 管理主机
docker run --privileged -itd --name manager mpi

## 创建节点
while [ "$node_num" -ge 1 ]
do 
  echo 创建节点"${node_num}"
  docker run --user vire --privileged -itd --name "node${node_num}" mpi
  node_num=$((node_num-1))
done


# 挂载nfs
docker exec manager mount -t nfs "${NFS_HOST}:${NFS_DIR}" /home/vire/cloud


# 生成keygen
docker exec -u vire manager ssh-keygen -t rsa -f /home/vire/.ssh/id_rsa -N ""

# 获取所有容器IP
./pod.sh

