resource "aws_vpc" "this" {
  cidr_block = "10.20.20.0/27"
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#enable_dns_support
  enable_dns_support = true
  tags = {
    "Name" = "Application-1"
  }
}
resource "aws_subnet" "private-2a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.20.0/28"
  availability_zone = "us-east-2a"
  tags = {
    "Name" = "Application-1-private-2a"
  }
}
resource "aws_subnet" "private-2b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.20.20.16/28"
  availability_zone = "us-east-2b"
  tags = {
    "Name" = "Application-1-private-2b"
  }
}
resource "aws_route_table" "this-rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "Application-1-route-table"
  }
}
resource "aws_route_table_association" "private-2a" {
  subnet_id      = aws_subnet.private-2a.id
  route_table_id = aws_route_table.this-rt.id
}
resource "aws_route_table_association" "private-2b" {
  subnet_id      = aws_subnet.private-2b.id
  route_table_id = aws_route_table.this-rt.id
}
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