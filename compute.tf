#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "amazon_ami" {
  filter {
    name   = "name"
    values = var.ami_name
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "app-server" {
  count                  = length(var.subnet_cidr_public)
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.amazon_ami.id
  vpc_security_group_ids = [aws_security_group.ec2_instance.id]
  subnet_id              = element(module.vpc.public_subnets.*.id, count.index)
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#associate_public_ip_address
  associate_public_ip_address = true
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  ebs_optimized = true
  monitoring    = true
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "app-server-${count.index + 1}"
  }
  user_data = filebase64("./user_data/user_data.tpl")
}