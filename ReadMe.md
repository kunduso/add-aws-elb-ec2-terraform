![Image](https://skdevops.files.wordpress.com/2022/07/65.image-1.png)
## Motivation
My objectives was to create an application load balancer and attach that to three EC2 instances hosted in three different availability zones in a region using Terraform.

I discussed the concept in detail in my notes at -[Add an application load balancer to AWS EC2 using Terraform.](http://skundunotes.com/2022/07/30/add-an-application-load-balancer-to-aws-ec2-using-terraform/)

*Note: I did not include the concepts of creating the EC2 instances, or installing a certificate, or route53 in this note.*

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