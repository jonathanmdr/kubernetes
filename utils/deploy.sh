#!/bin/bash

set -e

NAMESPACE="news-project"
NOT_FOUND="not found"

have_minikube=$(which minikube || echo "$NOT_FOUND")

if [[ "$have_minikube" == "$NOT_FOUND" ]]; then
    echo "'minikube' not found, this is mandatory"
    exit 1
fi

have_kubectl=$(which kubectl || echo "$NOT_FOUND")

if [[ "$have_kubectl" == "$NOT_FOUND" ]]; then
    echo "'kubectl' not found, this is mandatory"
    exit 1
fi

have_kubectx=$(which kubectx || echo "$NOT_FOUND")

if [[ "$have_kubectx" == "$NOT_FOUND" ]]; then
    echo "'kubectx' not found, this is mandatory"
    exit 1
fi

have_kubens=$(which kubens || echo "$NOT_FOUND")

if [[ "$have_kubens" == "$NOT_FOUND" ]]; then
    echo "'kubens' not found, this is mandatory"
    exit 1
fi

have_helm=$(which helm || echo "$NOT_FOUND")

if [[ "$have_helm" == "$NOT_FOUND" ]]; then
    echo "'helm' not found, this is mandatory"
    exit 1
fi

function create_namespace() {
    namespace=$(kubens | grep "$NAMESPACE" || echo "$NOT_FOUND")

    if [[ "$namespace" == "$NOT_FOUND" ]]; then
        kubectl create namespace "$NAMESPACE"    
    fi        
}

function deploy_database() {
    helm upgrade -f ./helm/database/values.yaml database-noticias ./helm/database --install --force
}

function deploy_administration() {
    helm upgrade -f ./helm/administration/values.yaml administration-noticias ./helm/administration --install --force
}

function deploy_portal() {
    helm upgrade -f ./helm/portal/values.yaml portal-noticias ./helm/portal --install --force
}

function deploy() {
    cd .. && \
    kubectx minikube && \
    create_namespace && \
    kubens "$NAMESPACE" && \
    deploy_database && \
    deploy_administration && \
    deploy_portal
}

deploy