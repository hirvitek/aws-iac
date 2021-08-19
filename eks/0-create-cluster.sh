#!/usr/bin/env sh

set -e

CLUSTER_NAME=eks-boilerplate
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Creating AWS EKS cluster...this might take a while"
eksctl create cluster -f "$SCRIPT_PATH"/cluster.yaml --kubeconfig "$HOME"/.kube/"${CLUSTER_NAME}"

echo "Cluster created, your kube config located at $KUBECONFIG"
echo "Waiting for resources"
sleep 10

cluster_data=$(aws eks describe-cluster --name care-eks-staging | jq -r '.')


echo "Deploying Nginx ingress controller and Load balancer"
helm install ingress-nginx ingress-nginx/ingress-nginx -f "$SCRIPT_PATH"/nginx-values.yaml