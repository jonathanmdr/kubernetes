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

Execute o script bash `setup_environment.sh` para montar o ambiente com os recursos necessários.

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
~$ chmod +x setup_environment.sh
~$ ./setup_environment.sh
```

</br>

[![node](https://github.com/jonathanmdr/kubernetes/blob/master/utils/setup_environment.sh)](Setup Linux)

</br>

## Deploy:

Execute o script bash `deploy.sh` para montar o ambiente com os recursos necessários.

</br>

#### Exemplo de uso:

```bash
~$ chmod +x deploy.sh
~$ ./deploy.sh
```

</br>

[![node](https://github.com/jonathanmdr/kubernetes/blob/master/utils/deploy.sh)](Deploy Application)