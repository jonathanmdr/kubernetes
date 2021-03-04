#!/bin/bash

set -e

KUBECTX_REPOSITORY="https://github.com/ahmetb/kubectx.git"
NOT_FOUND="not found"

have_curl=$(which curl || echo "$NOT_FOUND")

if [[ "$have_curl" == "$NOT_FOUND" ]]; then
    echo "'curl' not found, this is mandatory"
    exit 1
fi

have_git=$(which git || echo "$NOT_FOUND")

if [[ "$have_git" == "$NOT_FOUND" ]]; then
    echo "'git' not found, this is mandatory"
    exit 1
fi

have_docker=$(which docker || echo "$NOT_FOUND")

if [[ "$have_docker" == "$NOT_FOUND" ]]; then
    echo "'docker' not found, this is mandatory"
    exit 1
fi

clean_kubectx() {    
    rm -rf "$HOME"/.kubectx
}

update_bashrc_kubectx() {
cat << EOF >> "$HOME"/.bashrc
#kubectx and kubens
export PATH="$HOME"/.kubectx:\"$PATH"
EOF
}

install_kubectx() {
    clean_kubectx && \
    git clone "$KUBECTX_REPOSITORY" "$HOME"/.kubectx && \
    COMPDIR=$(pkg-config --variable=completionsdir bash-completion) && \
    sudo ln -sf "$HOME"/.kubectx/completion/kubens.bash "$COMPDIR"/kubens && \
    sudo ln -sf "$HOME"/.kubectx/completion/kubectx.bash "$COMPDIR"/kubectx && \
    update_bashrc=$(cat "$HOME"/.bashrc | grep "kubectx and kubens" || echo "$NOT_FOUND")

    if [[ "$update_bashrc" == "$NOT_FOUND" ]]; then
        update_bashrc_kubectx
    fi    
}

install_kubectl() {
    sudo apt-get update && \
    sudo apt-get install -y apt-transport-https gnupg2 curl && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
    sudo apt-get update && \
    sudo apt-get install -y kubectl
}

install_helm() {
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add - && \
    sudo apt-get install apt-transport-https --yes && \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    sudo apt-get update && \
    sudo apt-get install helm
}

clean_minikube() {
    minikube delete && \
    sudo rm -rf /usr/local/bin/minikube
}

install_minikube() {
    sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
    sudo install minikube /usr/local/bin/minikube && \
    sudo rm minikube && \
    minikube start && \
    minikube addons enable ingress && \
    minikube addons enable dashboard && \
    minikube addons enable metrics-server && \
    printf "\n\n\033[4;33m Enabled Addons \033[0m" && \
    minikube addons list | grep STATUS && minikube addons list | grep enabled && \
    printf "\n\n\033[4;33m Current status of Minikube \033[0m" && \
    minikube status
}

have_kubectx=$(which kubectx || echo "$NOT_FOUND")

if [[ "$have_kubectx" == "$NOT_FOUND" ]]; then
    echo "'kubectx' not found, installation in progress..."    
    install_kubectx
else
    echo "'kubectx' found, updating to latest version..."
    clean_kubectx && \
    install_kubectx
fi

have_kubectl=$(which kubectl || echo "$NOT_FOUND")

if [[ "$have_kubectl" == "$NOT_FOUND" ]]; then
    echo "'kubectl' not found, installation in progress..."    
    install_kubectl
else
    echo "'kubectl' found, updating to latest version..."
    sudo apt-get update
fi

have_helm=$(which helm || echo "$NOT_FOUND")

if [[ "$have_helm" == "$NOT_FOUND" ]]; then
    echo "'helm' not found, installation in progress..."    
    install_helm
else
    echo "'helm' found, updating to latest version..."
    sudo apt-get update
fi

have_minikube=$(which minikube || echo "$NOT_FOUND")

if [[ "$have_minikube" == "$NOT_FOUND" ]]; then
    echo "'minikube' not found, installation in progress..."    
    install_minikube
else
    echo "'minikube' found, updating to latest version..."
    clean_minikube && \
    install_minikube
fi
