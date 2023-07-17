FROM ubuntu:22.04

LABEL vendor="vire" \
  version="test"  \
  description="this is vire mpi simulation image" \
  maintainer="taotao7"


ENV OMPI_ALLOW_RUN_AS_ROOT=1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

RUN useradd -m vire 

RUN mkdir /home/vire/cloud && \
  mkdir /home/vire/.ssh && \ 
  chown vire:vire /home/vire/.ssh


WORKDIR /home/vire

RUN apt-get update && \
  apt-get upgrade -yy && \
  apt-get install -yy \
  gcc \
  g++ \
  make \
  cmake \
  vim \
  openssh-server \
  sshpass \
  dialog \
  nfs-common \
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
  echo "vire:zxczxc" | chpasswd && \
  echo "root:zxczxc" | chpasswd  




#COPY ./example /home/vire/cloud
#COPY ./hostfile /home/vire/cloud

# RUN   cd openmpi-4.1.5 && \
#   ./configure --prefix=/usr/local && make install -j &&\
#   ldconfig


