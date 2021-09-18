init:
	. ./env.sh && terraform init -backend-config="bucket=$${S3_BUCKET_NAME}" -backend-config="key=$${S3_BUCKET_KEY}"

apply:
	. ./env.sh && terraform apply

destroy:
	. ./env.sh && terraform destroy