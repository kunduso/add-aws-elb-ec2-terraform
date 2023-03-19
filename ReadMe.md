[![terraform-infra-provisioning](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/terraform.yml/badge.svg)](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/terraform.yml) 
[![checkov-static-analysis-scan](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/code-scan.yml/badge.svg?branch=main)](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/code-scan.yml)
![Image](https://skdevops.files.wordpress.com/2023/03/72-image-1.png)
## Motivation
My objectives was to create an application load balancer and attach that to three Amazon EC2 instances hosted in three different availability zones in a region using **Terraform and GitHub Actions.**

I discussed the concept in detail in my notes at -[CI-CD with Terraform and GitHub Actions to deploy to AWS.](https://skundunotes.com/2023/03/07/ci-cd-with-terraform-and-github-actions-to-deploy-to-aws/)

*Note: I did not include the concepts of creating the EC2 instances, or installing a certificate, or route53 in this note.*

## Prerequisites
For this code to function without errors, I created an OpenID connect identity provider in Amazon Identity and Access Management that has a trust relationship with this GitHub repository. You can read about it [here](https://skundunotes.com/2023/02/28/securely-integrate-aws-credentials-with-github-actions-using-openid-connect/) to get a detailed explanation with steps.
<br />I stored the `ARN` of the `IAM Role` as a GitHub secret which is referred in the [`terraform.yml`](https://github.com/kunduso/add-aws-elb-ec2-terraform/blob/9fa61ad4792c73f233eb1dccb61c477c957d4cdb/.github/workflows/terraform.yml#L33-L38) file.
## Usage
Ensure that the policy attached to the IAM role whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />
<br />Review the code including the [`terraform.yml`](./.github/workflows/terraform.yml) to understand the steps in the GitHub Actions pipeline. Also review the `terraform` code to understand all the concepts associated with creating an AWS VPC, subnets, internet gateway, route table, and route table association.
<br />If you want to check the pipeline logs, click on the **Build Badge** (terrform-infra-provisioning) above the image in this ReadMe.
