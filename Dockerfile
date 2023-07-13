FROM ubuntu:latest

LABEL vendor="vire" \
  version="test"  \
  description="this is vire mpi simulation image" \
  maintainer="taotao7"

ENV OMPI_ALLOW_RUN_AS_ROOT 1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM 1

RUN mkdir /vire/cloud

WORKDIR /vire

RUN apt-get update && \
  apt-get upgrade -yy && \
  apt-get install -yy \
  gcc \
  g++ \
  make \
  cmake \
  vim \
  openssh-server\
  nfs-common\
  rpcbind\
  openmpi-bin=4.1.2-2ubuntu1\
  zlib1g-dev \
  zlib1g \
  gfortran \
  gosu \
  libblas-dev \
  bzip2 \
  libopenmpi-dev=4.1.2-2ubuntu1 && \
  apt-get clean && \
  apt-get autoclean && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
  echo "vire:zxczxc" |chpasswd && \
  echo "root:zxczxc" | chpasswd && \
  service ssh start && \
  service rpcbind start  


# ADD ./openmpi.tar.gz /root

# RUN   cd openmpi-4.1.5 && \
#   ./configure --prefix=/usr/local && make install -j &&\
#   ldconfig


