resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  name = "postgres-cluster-params"
  family = "aurora-postgresql12"

  parameter {
    name  = "rds.force_ssl"
    value = 1
  }
}