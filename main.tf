# https://docs.aws.amazon.com/glue/latest/dg/set-up-vpc-dns.html
resource "aws_vpc" "this" {
  cidr_block = "10.20.20.0/26"
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_dns_support
  enable_dns_support = true
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_dns_hostnames
  enable_dns_hostnames = true
  tags = {
    "Name" = "Application-1"
  }
}
resource "aws_subnet" "private" {
  count             = length(var.subnet_cidr_private)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidr_private[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    "Name" = "Application-1-private"
  }
}
# resource "aws_subnet" "private-2a" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "10.20.20.0/28"
#   availability_zone = "us-east-2a"
#   tags = {
#     "Name" = "Application-1-private-2a"
#   }
# }
# resource "aws_subnet" "private-2b" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "10.20.20.16/28"
#   availability_zone = "us-east-2b"
#   tags = {
#     "Name" = "Application-1-private-2b"
#   }
# }
# resource "aws_subnet" "private-2c" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "10.20.20.32/28"
#   availability_zone = "us-east-2c"
#   tags = {
#     "Name" = "Application-1-private-2c"
#   }
# }
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-1-route-table"
  }
}
resource "aws_route_table_association" "private" {
  count          = length(var.subnet_cidr_private)
  subnet_id      = element(aws_subnet.*.id, count.index)
  route_table_id = aws_route_table.this-rt.id
}
# resource "aws_route_table_association" "private-2b" {
#   subnet_id      = aws_subnet.private-2b.id
#   route_table_id = aws_route_table.this-rt.id
# }
# resource "aws_route_table_association" "private-2c" {
#   subnet_id      = aws_subnet.private-2c.id
#   route_table_id = aws_route_table.this-rt.id
# }
resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-1-gateway"
  }
}
resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.this-rt.id
  gateway_id             = aws_internet_gateway.this-igw.id
}