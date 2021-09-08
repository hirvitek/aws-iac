#!/usr/bin/env sh

set -e

. ./env.sh
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Creating AWS EKS cluster...this might take a while"
eksctl create cluster -f "$SCRIPT_PATH"/cluster.yaml --kubeconfig "$KUBECONFIG"

echo "Cluster created, your kube config located at $KUBECONFIG"
echo "Waiting for resources"
sleep 10

# Remove the previous kube config and download the one with correct permissions
echo "Creating kubeconfig"
rm "$KUBECONFIG"
aws eks update-kubeconfig --name "$CLUSTER_NAME" --kubeconfig "$KUBECONFIG"

echo "Deploying Nginx ingress controller and Load balancer"
helm upgrade -i ingress-nginx ingress-nginx/ingress-nginx \
  -f "$SCRIPT_PATH"/nginx-values.yaml \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-cert"="${AWS_ACM_CERTIFICATES_ARN}" \
  -n ingress-nginx --create-namespace

echo "Deploying Oauth2 proxy"
helm upgrade -i oauth2-proxy oauth2-proxy/oauth2-proxy \
  -f oauth2-proxy-values.yaml \
  --set config.clientID="${CLIENT_ID}" \
  --set config.clientSecret="${CLIENT_SECRET}" \
  --set config.cookieSecret="${COOKIE_SECRET}" \
  --set extraArgs.oidc-jwks-url="${OIDC_JWKS_URL}" \
  --set extraArgs.oidc-issuer-url="${OIDC_ISSUER_URL}" \
  --set ingress.hosts[0]="${LINKERD_DASHBOARD_HOST}"

echo "Deploying sample service"
helm upgrade -i sample-service sample-service/

echo "Deploying linkerd"
linkerd check --pre && linkerd install | kubectl apply -f - && linkerd viz install | kubectl apply -f - && linkerd check

echo "Deploying linkerd dashboard ingres"
kubectl apply -f linkerd-dashboard.yaml

helm upgrade -i resources templates/ --set linkerdDashboardHost="${LINKERD_DASHBOARD_HOST}"