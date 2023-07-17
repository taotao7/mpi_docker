
echo "输入节点数量"
read -r node_num 

while [ $node_num -ge 1 ]
do 
  echo 创建节点"${node_num}"
  docker run --user vire  --privileged -itd --name "node_${node_num}" mpi
  node_num=$((node_num-1))
done
