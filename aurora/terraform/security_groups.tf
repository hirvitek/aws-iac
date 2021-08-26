resource "aws_security_group" "db_security_group" {
  name = "cluster_security_group"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "db_security_group_inbound_rule" {
  from_port = 5432
  to_port = 5432
  protocol = "tcp"
  security_group_id = aws_security_group.db_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  type = "ingress"
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_security_group.id
}