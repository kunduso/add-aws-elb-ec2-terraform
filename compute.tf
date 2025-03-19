# resource "aws_security_group" "http-sg" {
#   name        = "allow_http_access"
#   description = "allow inbound http traffic"
#   vpc_id      = aws_vpc.this.id

#   ingress {
#     description = "from my ip range"
#     from_port   = "80"
#     to_port     = "80"
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = "0"
#     protocol    = "-1"
#     to_port     = "0"
#   }
#   tags = {
#     "Name" = "Application-1-sg"
#   }
# }
data "aws_ami" "amazon_ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20220606.1-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}
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
  tags = {
    Name = "app-server-${count.index + 1}"
  }
  user_data = filebase64("./user_data/user_data.tpl")
}