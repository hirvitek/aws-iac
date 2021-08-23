module "aurora_cluster" {
  source = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"

  name = "aurora-postgresql"
  engine = "aurora-postgresql"
  engine_version = "12.7"
  instance_type = "db.t3.medium"

  password = jsondecode(aws_secretsmanager_secret_version.cluster_admin_credentials_version.secret_string)["password"]
  username = jsondecode(aws_secretsmanager_secret_version.cluster_admin_credentials_version.secret_string)["username"]
  create_random_password = false

  vpc_id = ""
  subnets = []

  replica_count = 1
  create_security_group = true

  storage_encrypted = true
  apply_immediately = true
  iam_database_authentication_enabled = true
  publicly_accessible = true
  backup_retention_period = 1
}