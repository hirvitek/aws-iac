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


## How to use the parameters in other templates
If you have decided to export the parameters in SSM Parameter store, you can simply reference your parameter via
Cloudformation parameter this way.

```yaml

Parameters:
  MyParameter:
    Type: AWS::SSM::Parameter::Value<String>
```

and then on `--parametes-override` you can pass the key:

```
MyParameter: /vpcteststack/publicSubnet1/id
```

The naming schema is always the same: 

```
/<Stack name in which the parameter belogs>/<name of the resource>/<type of value>
```

# Module

You can use the vpc 2azs as a module:

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: "Sample"
Resources:
  MyVPC:
    Type: Hivitek::VPC::2AZS::MODULE
    Properties:
      Environment: dev
      Appname: my-test-vpc
      ExportParameters: true
      FlowLogsEnabled: true
      ClassB: 20
      TrafficType: ALL
      RetentionInDays: 30
     
```