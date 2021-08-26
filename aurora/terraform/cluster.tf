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

  vpc_id = var.vpc_id
  subnets = data.aws_subnet_ids.subnets_ids.ids
  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  replica_count = 1
  //TODO Remove
  create_security_group = true
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_parameter_group.name

  storage_encrypted = true
  apply_immediately = true
  iam_database_authentication_enabled = true
//  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery", "postgresql"]
  performance_insights_enabled = true
//  create_monitoring_role = true

  // TODO: change
  backup_retention_period = 1

  // TODO: remove
  publicly_accessible = true
}