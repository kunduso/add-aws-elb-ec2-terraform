data "aws_availability_zones" "available" {
  state = "available"
}
#https://registry.terraform.io/modules/kunduso/vpc/aws/1.0.3
module "vpc" {
  # Alinging with Checkov rule CKV_TF_1 and using a Git URLs with a commit hash revision. 
  # Details available in below link:
  # https://docs.prismacloud.io/en/enterprise-edition/policy-reference/supply-chain-policies/terraform-policies/ensure-terraform-module-sources-use-git-url-with-commit-hash-revision
  source = "git::https://github.com/kunduso/terraform-aws-vpc.git?ref=53480d4bee43d23c547e931672d5f896e6e559c3" # commit hash of version 1.0.3
  # source                  = "kunduso/vpc/aws"
  # version                 = "1.0.3"
  region                  = var.region
  enable_dns_hostnames    = true
  enable_dns_support      = true
  enable_flow_log         = true
  enable_internet_gateway = true
  vpc_name                = var.name
  vpc_cidr                = var.vpc_cidr
  subnet_cidr_public      = var.subnet_cidr_public
}