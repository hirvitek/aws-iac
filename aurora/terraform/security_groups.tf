resource "aws_db_security_group" "cluster_security_group" {
  name = ""
  ingress {
    security_group_id = aws_security_group.db_security_group.id
  }
}

resource "aws_security_group" "db_security_group" {}

resource "aws_security_group_rule" "db_security_group_inbound_rule" {
  from_port = 0
  protocol = ""
  security_group_id = aws_security_group.db_security_group.id
  to_port = 0
  type = ""
}