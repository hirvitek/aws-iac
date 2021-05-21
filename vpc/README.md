## Deployment

You can use this script to deploy this template

```bash
export ENV=${1:-dev}
export APPNAME=<your app name>
export STACK_NAME=${APPNAME}-${ENV}

## the actual deployment step
aws cloudformation deploy \
  --template-file template.yaml \
  --stack-name "${STACK_NAME}" \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides \
  Environment="${ENV}" \
  # Other parameters here
```

## Parameters

- `ExportParameters (True|False)`: you can choose to export resources arn or id to use reference it into
other templates
- `FlowLogsEnabled (True|False)`: you can enable VPC Flow logs
- `TrafficType`: input the traffic type that the logs will capture
- `RetentionInDays`: retention days for the logs
