#!/bin/bash

# Define users
# Define users in an array
USERS=(
    "user1"
    "user2"
    "user3"
    "user4"
    "user5"
    "user6"
    "user7"
    "user8"
    "user9"
    "user10"
)

# Define role bindings
NAMESPACE_ROLE="super-edit"
CLUSTER_ROLE="global-view"

# Ensure KUBECONFIG is set
if [ -z "$KUBECONFIG" ]; then
    echo "KUBECONFIG is not set. Please export your kubeconfig file."
    exit 1
fi

# Create cluster default role 
kubectl apply -f infra/templates/cluster-default-role.yaml

# Create directory for generated kubeconfigs
mkdir -p ./infra/generated-kubeconfigs/

# Loop through users
for USER in "${USERS[@]}"; do
    echo "Processing user: $USER"
    
    # Create namespace
    kubectl create namespace "$USER" --dry-run=client -o yaml | kubectl apply -f -
    
    infra/templates/sa-kubeconfig-gen.sh $USER-sa $USER infra/templates/namespaced-default-role.yaml

    kubectl create clusterrolebinding "$USER-sa-$CLUSTER_ROLE" \
        --clusterrole="$CLUSTER_ROLE" \
        --serviceaccount="$USER:$USER-sa" --dry-run=client -o yaml | kubectl apply -f -

    echo "Kubeconfig for user $USER created: $USER_KUBECONFIG"
done

echo "All users processed successfully."
