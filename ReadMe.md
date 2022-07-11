![Image](https://skdevops.files.wordpress.com/2022/07/64.image-1.png)
## Motivation
My objectives was to use Terraform to create a bare-bone web server on AWS EC2. I discuss from creating the VPC, subnets, internet gateway, security group, and EC2 instances to finally automating the process via Terraform and user data.

I discussed the concept in detail in my notes at -[Create a web-server on AWS EC2 instance using Terraform and user data.](https://skundunotes.com/2022/07/11/create-a-web-server-on-aws-ec2-instance-using-terraform-and-user-data/)

*Note: I did not include the concepts of load balancing, installing a certificate, or route53 in this note.*

## Prerequisites
I installed `terraform` before I worked on this repository. Installation information is available in the [install guide.](https://www.terraform.io/downloads.html) <br />I used the `access_key` and the `secret_key` of an IAM user that had permission to create all the resources managed via this `terraform` code.
<br />I created a `terraform.tfvars` file to store them.
## Usage
Ensure that the IAM user whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />
<br />Review the code, especially the `main.tf` to understand all the concepts associated with creating an AWS VPC, subnets, internet gateway, route table, and route table association.

<br />Next, run `terraform init` 
<br />Then run `terraform plan`
<br />And finally run `terraform apply`