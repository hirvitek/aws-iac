#!/usr/bin/env sh

export ENV=
export PROFILE=
export REGION=ap-southeast-1
export PROJECT=ssm-jumper-${ENV}

set -e

echo profile "${PROFILE}"

cfn-lint -t ${PROJECT}.yaml

aws cloudformation deploy --profile "${PROFILE}" --region "${REGION}" \
  --template-file ${PROJECT}.yaml \
  --stack-name "${PROJECT}" \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides \
  Env="${ENV}"
