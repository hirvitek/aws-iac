module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "test-instance"

  ami = data.aws_ssm_parameter.ami.value
  instance_type = "t2.micro"
  monitoring = true
  vpc_security_group_ids = [
    aws_security_group.instance_security_group.id
  ]

  // Pick the first of the subnet in the vpc
  subnet_id = element(tolist(data.aws_subnet_ids.subnets_ids.ids), 0)
  user_data = data.template_file.userdata.rendered
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  tags = {
    Terraform = "true"
    Name = "test-instance"
    app = "ec2-test-host"
    description = "Boostrap terraform for test ec2 instance"
  }
}