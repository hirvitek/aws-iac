resource "aws_security_group" "instance_security_group" {
  name = "instance_sg"
  vpc_id = var.vpc_id
  tags = {
    Terraform = "true"
    Name = "instance_sg"
    app = "ec2-test-host"
  }
}

resource "aws_security_group_rule" "security_group_inbound_rule_http" {
  protocol = "tcp"
  security_group_id = aws_security_group.instance_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  type = "ingress"
  from_port = 80
  to_port = 80
}

resource "aws_security_group_rule" "security_group_inbound_rule_https" {
  protocol = "tcp"
  security_group_id = aws_security_group.instance_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  type = "ingress"
  from_port = 443
  to_port = 443
}

resource "aws_security_group_rule" "security_group_inbound_rule_ssh" {
  protocol = "tcp"
  security_group_id = aws_security_group.instance_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
  type = "ingress"
  from_port = 22
  to_port = 22
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_security_group.id
}