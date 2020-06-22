#!/bin/bash

## INSTALLING DOCKER RUNTIME ##
curl "https://get.docker.com/" | bash
mkdir /etc/docker
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF
printf "\nUseDNS no\n" >> /etc/ssh/sshd_config
mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload
systemctl restart docker

## INSTALLING KUBELET, KUBECTL, KUBEADM

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl wget
sudo apt-mark hold kubelet kubeadm kubectl

systemctl start docker && systemctl enable docker
systemctl start kubelet && systemctl enable kubelet
kubeadm config images pull

