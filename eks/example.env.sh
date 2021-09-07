#!/usr/bin/env sh

export CLUSTER_NAME=""
export KUBECONFIG=$HOME"/.kube/"${CLUSTER_NAME}
export AWS_ACM_CERTIFICATES_ARN=arn:aws:acm:$AWS_REGION:$AWS_ACCOUNT_ID:certificate/$AWS_ACM_CERTIFICATE_ID
export CLIENT_ID=""
export CLIENT_SECRET=""
export COOKIE_SECRET=$(openssl rand -base64 32 | head -c 32 | base64)
export OIDC_JWKS_URL=https://$DOMAIN/.well-known/jwks.json
export OIDC_ISSUER_URL=https://$DOMAIN
export HOST_1=sub.yourcompany.com