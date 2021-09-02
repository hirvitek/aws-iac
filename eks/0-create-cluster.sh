#!/usr/bin/env sh

set -e

export CLUSTER_NAME=eks-boilerplate
export KUBECONFIG=$HOME"/.kube/"${CLUSTER_NAME}
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Creating AWS EKS cluster...this might take a while"
eksctl create cluster -f "$SCRIPT_PATH"/cluster.yaml --kubeconfig "$KUBECONFIG"

echo "Cluster created, your kube config located at $KUBECONFIG"
echo "Waiting for resources"
sleep 10

# Remove the previous kube config and download the one with correct permissions
echo "Creating kubeconfig"
rm "$KUBECONFIG"
aws eks update-kubeconfig --name $CLUSTER_NAME --kubeconfig "$KUBECONFIG"

echo "Deploying Nginx ingress controller and Load balancer"
helm upgrade -i ingress-nginx ingress-nginx/ingress-nginx -f "$SCRIPT_PATH"/nginx-values.yaml

echo "Deploying sample service"
helm upgrade -i sample-service sample-service/