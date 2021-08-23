resource "random_password" "password" {
  length           = 32
  special          = false
}

resource "aws_secretsmanager_secret" "cluster_admin_credentials" {
  name                    = "rds_admin"
  description             = "RDS Admin password"
  recovery_window_in_days = 14
}

resource "aws_secretsmanager_secret_version" "cluster_admin_credentials_version" {
  secret_id     = aws_secretsmanager_secret.cluster_admin_credentials.id
  secret_string = jsonencode({
    username: "rds_admin"
    password: random_password.password.result
  })
}

resource "aws_secretsmanager_secret_rotation" "cluster_admin_credentials_rotation" {
  secret_id = aws_secretsmanager_secret.cluster_admin_credentials.id
  rotation_lambda_arn = aws_lambda_function.example.arn

  rotation_rules {
    automatically_after_days = 30
  }
}