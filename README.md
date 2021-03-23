# kubernetes
Projeto do curso de Kubernetes, conhecendo e aplicando os conceitos de Pod, Service, ConfigMap, Deployment, StatefulSet, PersistentVolume, PersistentVolumeClaim, StorageClass, Probes e HPA.

Também conheceremos e aplicaremos os conceitos de uso do helm como gerenciador de pacotes para aplicações em cluster kubernetes.

[![node](https://img.shields.io/badge/Kubernetes-stable-blue.svg)](https://kubernetes.io)
[![node](https://img.shields.io/badge/Minikube-v1.17.1-blue.svg)](https://minikube.sigs.k8s.io)
[![node](https://img.shields.io/badge/Helm-v3.5.2-blue.svg)](https://helm.sh/)

## Sobre o Projeto:
O projeto consiste em um site de notícias, onde temos uma divisão de dois microsserviços, sendo um deles uma aplicação administrativa para publicar e/ou remover notícias, e um segundo que é um portal de notícias 
que lista todas as notícias que são cadastradas pela aplicação admin.

</br>

## Arquitetura:

[![node](https://github.com/jonathanmdr/kubernetes/blob/master/docs/project_architecture.png)](https://github.com/jonathanmdr/Survival-api/blob/master)

</br>

## Setup Ambiente Linux:

Execute o script bash `setup_k8s_dev_environment.sh` para montar o ambiente com os recursos necessários.

</br>

Requisitos |
--|
`curl` |
`git` |
`docker` |

</br>

Intalação |
--|
`kubectx` |
`kubens` |
`kubectl` |
`helm` |
`minikube` |

</br>

#### Exemplo de uso:

```bash
~$ chmod +x setup_k8s_dev_environment.sh
~$ ./setup_k8s_dev_environment.sh bash #Para quem utiliza o .bashrc
~$ ./setup_k8s_dev_environment.sh zsh #Para quem utiliza o .zshrc
```

</br>

[Setup Linux File](https://github.com/jonathanmdr/kubernetes/blob/master/utils/setup_k8s_dev_environment.sh)

</br>

## Deploy:

Execute o script bash `deploy.sh` para subir a aplicação toda no cluster kubernetes local configurado anteriormente no setup.

</br>

#### Exemplo de uso:

```bash
~$ chmod +x deploy.sh
~$ ./deploy.sh
```

</br>

[Deploy Application File](https://github.com/jonathanmdr/kubernetes/blob/master/utils/deploy.sh)