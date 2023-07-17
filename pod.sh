#!/bin/bash

# 获取所有正在运行的容器的 ID
container_ids=$(docker container ls -q)

# 检查是否存在 ip.txt 文件
if [ -f "./cloud/hosts" ]; then
  # 如果存在，则删除该文件
  rm ./cloud/hosts
fi

# 遍历容器 ID 并获取每个容器的名称和 IP 地址
for id in $container_ids
do
  # 获取容器的名称
  name=$(docker container inspect --format "{{ .Name }}" $id)
  name=${name#/}  # 去掉名称前面的斜杠

  # 获取容器的 IP 地址
  ip=$(docker container inspect --format "{{ .NetworkSettings.IPAddress }}" $id)

  echo "开始执行节点-------${name}"
  # 启动ssh服务
  docker exec -u root $name service ssh start
  # 启动rpcbind服务
  docker exec -u root $name service rpcbind start
  # 挂载nfs
  docker exec -u root $name mount -t nfs "${NFS_HOST}:${NFS_DIR}" /home/vire/cloud


  # 在管理主机打通ssh
  echo "开始复制公钥到每个子节点"
  docker exec -u vire manager sshpass -p zxczxc scp /home/vire/.ssh/id_rsa.pub vire@${ip}:/home/vire/.ssh/authorized_keys
  wait

  # 输出容器的名称和 IP 地址
  echo "$ip $name" >> ./cloud/hosts
done
