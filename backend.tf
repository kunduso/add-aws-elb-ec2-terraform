terraform {
  backend "s3" {
    bucket  = "kunduso-terraform-remote-bucket"
    encrypt = true
    key     = "tf/add-aws-elb-ec2-terraform/terraform.tfstate"
    region  = "us-east-2"
  }
}