#!/bin/bash

set -e

CONTEXT="minikube"
NAMESPACE="news-project"
DEFAULT_NAMESPACE="default"
NOT_FOUND="not found"

DATABASE_RELEASE_NAME="database-noticias"
ADMIN_RELEASE_NAME="administration-noticias"
PORTAL_RELEASE_NAME="portal-noticias"

CHARTS_PATH="../helm"

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
DEFAULT=$(tput sgr0)


error_message() {
    printf "\n${RED} ERROR: ${DEFAULT}%s \n\n" "$1"
}

warning_message() {
    printf "\n${YELLOW} WARNING: ${DEFAULT}%s \n\n" "$1"
}

info_message() {
    printf "\n${GREEN} INFO: ${DEFAULT}%s \n\n" "$1"
}

validate_mandatory_resource() {
    resource_exists=$(which "$1" || echo "$RESOURCE_NOT_FOUND")

    if [[ "$resource_exists" == "$RESOURCE_NOT_FOUND" ]]; then
        warning_message "'$1' not found, this is mandatory."
        exit 1
    fi
}

startup_validation() {
    resources_required=("minikube" "kubectl" "kubectx" "kubens" "helm")

    for resource in "${resources_required[@]}"; do
        validate_mandatory_resource "$resource"
    done
}

create_namespace() {
    namespace=$(kubens | grep "$NAMESPACE" || echo "$NOT_FOUND")

    if [[ "$namespace" == "$NOT_FOUND" ]]; then
        kubectl create namespace "$NAMESPACE"
    fi
}

delete_namespace() {
    kubectl delete namespace "$NAMESPACE"
}

deploy_database() {
    helm upgrade -f ./database/values.yaml "$DATABASE_RELEASE_NAME" ./database --install --reuse-values
}

undeploy_database() {
    helm uninstall "$DATABASE_RELEASE_NAME"
}

deploy_administration() {
    helm upgrade -f ./administration/values.yaml "$ADMIN_RELEASE_NAME" ./administration --install --reuse-values
}

undeploy_administration() {
    helm uninstall "$ADMIN_RELEASE_NAME"
}

deploy_portal() {
    helm upgrade -f ./portal/values.yaml "$PORTAL_RELEASE_NAME" ./portal --install --reuse-values
}

undeploy_portal() {
    helm uninstall "$PORTAL_RELEASE_NAME"
}

deploy() {
    pushd "$CHARTS_PATH" && \
    kubectx "$CONTEXT" && \
    create_namespace && \
    kubens "$NAMESPACE" && \
    deploy_database && \
    deploy_administration && \
    deploy_portal && \
    popd && \
    kubens "$DEFAULT_NAMESPACE" && \
    info_message "Deploy successfully"
}

undeploy() {
    kubectx "$CONTEXT" && \
    kubens "$NAMESPACE" && \
    undeploy_portal && \
    undeploy_administration && \
    undeploy_database && \
    delete_namespace && \
    warning_message "PVs are not excluded from the cluster automatically, a manual intervention is required." && \
    kubens "$DEFAULT_NAMESPACE" && \
    info_message "Undeploy successfully"
}

startup_validation

if [ -z "$1" ]; then
    while [ -z "$parameter" ]
    do
        read -rp "Inform a parameter: (up/down) -> " parameter
    done
else
    parameter="$1"
fi

case "$parameter" in
    up)
    deploy
    ;;

    down)
    undeploy
    ;;

    *)
    error_message "The parameter does not valid."
    exit 1
    ;;
esac
