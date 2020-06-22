# Deploying a GoLang counter app on Docker Compose and Kubernetes cluster
## Descritpion
This repo shows completely automated deployment of the go app on docker compose. Then it deploys a one node k8s cluster and deploys the same app using the yaml manifests under `./kubernetes/app_yamls`

## Getting Started
### Pre-Requisites
1. Python
2. Pip (for installing ansible)
3. Ansible
4. Vagrant
5. VirtualBox

### Starting automated deployment
```shell
[root@fedora folder]# ./Start.sh
```
This will deploy app on both, docker compose and kubernetes

### Manual Deployment
For deploying app in docker compose
```shell
[root@fedora folder]# vagrant up
```

For deploying app in kubernetes cluster
```shell
[root@fedora folder]# cd kubernetes
[root@fedora kubernetes]# vagrant up
```
**Points to Note**
1. Build Image may take long, the GoLang image is around 800MB
2. Both deployments take place on seperate VMs
3. VM creation used linked clone for faster creation
4. Docker-compose module and kubernetes modules were not used in Ansible as they add additional dependency on client side for installing docker-py(python2.x) or docker(python3.x)

## Accessing the app
For Docker Compose app is accessible at
```
http://localhost:8000
```
For Kubernetes app is accessible at
```
http://192.168.50.4:32000
```
## Repository Tree
```
.
├── daemon.json                             (Optimizations for docker daemon)
├── demo-ops                                (Folder contantaining the app)
│   ├── docker-compose.yaml                 (For deployment on docker compose)
│   ├── Dockerfile                          (For building the app)
│   ├── go.mod
│   ├── go.sum
│   ├── main.go
│   └── Makefile
├── deploy.yaml                             (Vagrant ansible provisioner for docker compose)
├── kubernetes                              (Contains all k8s deployment files)
│   ├── app_yamls
│   │   ├── demo-ops-deployment.yaml        (Application deployment)
│   │   ├── demo-ops-namespace.yaml         (Creating namespace for application)
│   │   ├── demo-ops-quota.yaml             (Creating Resource Quota for the app deployment)
│   │   └── demo-ops-service.yaml           (Creating NodePort service for exposing app)
│   ├── k8s-deploy.yaml                     (Starts the k8s cluster and deploys the app on cluster)
│   ├── k8s.sh                              (Bootstraping the k8s cluster)
│   └── Vagrantfile                         (Vagrant file for k8s deployment)
├── README.md                               (-->THIS FILE<--)
├── Start.sh                                (Automates both deployment)
└── Vagrantfile                             (Vagrant file for docker compose deployment)
```
