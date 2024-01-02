[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/)[![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/add-aws-elb-ec2-terraform)](https://github.com/kunduso/add-aws-elb-ec2-terraform/pulls?q=is%3Apr+is%3Aclosed)[![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/add-aws-elb-ec2-terraform)](https://GitHub.com/kunduso/add-aws-elb-ec2-terraform/pull/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/add-aws-elb-ec2-terraform)](https://github.com/kunduso/add-aws-elb-ec2-terraform/issues?q=is%3Aissue+is%3Aclosed)[![GitHub issues](https://img.shields.io/github/issues/kunduso/add-aws-elb-ec2-terraform)](https://GitHub.com/kunduso/add-aws-elb-ec2-terraform/issues/)
[![terraform-infra-provisioning](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/terraform.yml/badge.svg)](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/terraform.yml) 
[![checkov-static-analysis-scan](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/code-scan.yml/badge.svg?branch=main)](https://github.com/kunduso/add-aws-elb-ec2-terraform/actions/workflows/code-scan.yml)
[![infracost](https://img.shields.io/endpoint?url=https://dashboard.api.infracost.io/shields/json/06af6e89-01e0-4bb5-bf85-ea19a0d3327a/repos/d7b4f62a-ed9e-4c0e-86f1-0ef3eb090cfb/branch/e9ba2997-4ca7-4a8e-9db5-8cde6e98f7fa)](https://dashboard.infracost.io/org/skundudev/repos/d7b4f62a-ed9e-4c0e-86f1-0ef3eb090cfb?tab=settings)
![Image](https://skdevops.files.wordpress.com/2023/03/72-image-1.png)
## Motivation
My objectives was to create an application load balancer and attach that to three Amazon EC2 instances hosted in three different availability zones in a region using **Terraform and GitHub Actions.**

<br />If you are interested in learning about how to create an external application load balancer with Amazon EC2 instances in a **private subnet**, check out the code in this repository: [add-aws-elb-ec2-private-subnet-terraform](https://github.com/kunduso/add-aws-elb-ec2-private-subnet-terraform)
<br />Later, I also automated the process of provisioning the resources using GitHub Actions pipeline and I discussed that in detail at -[CI-CD with Terraform and GitHub Actions to deploy to AWS.](https://skundunotes.com/2023/03/07/ci-cd-with-terraform-and-github-actions-to-deploy-to-aws/)
<br />If you are interested in learning about how to create an external application load balancer with Amazon EC2 instances in a **private subnet**, check out the code in this repository: [add-aws-elb-ec2-terraform](https://github.com/kunduso/add-aws-elb-ec2-terraform)
<br />I also added **Infracost** estimates to this repository. You can checkout the monthly cost badge at the top of this ReadMe file with the cost details. If you are interested in learning about that, checkout my note on -  [estimate AWS Cloud resource cost with Infracost, Terraform, and GitHub Actions.](https://skundunotes.com/2023/07/17/estimate-aws-cloud-resource-cost-with-infracost-terraform-and-github-actions/)

<br />*Note: I did not include the concepts of creating the EC2 instances, or installing a certificate, or route53 in this note.*

## Prerequisites
For this code to function without errors, I created an OpenID connect identity provider in Amazon Identity and Access Management that has a trust relationship with this GitHub repository. You can read about it [here](https://skundunotes.com/2023/02/28/securely-integrate-aws-credentials-with-github-actions-using-openid-connect/) to get a detailed explanation with steps.
<br />I stored the `ARN` of the `IAM Role` as a GitHub secret which is referred in the [`terraform.yml`](https://github.com/kunduso/add-aws-elb-ec2-terraform/blob/9fa61ad4792c73f233eb1dccb61c477c957d4cdb/.github/workflows/terraform.yml#L33-L38) file.
<br />As part of the **Infracost** integration, I also created a `INFRACOST_API_KEY` and stored that as a GitHub Actions secret. I also managed the cost estimate process using a GitHub Actions variable `INFRACOST_SCAN_TYPE` where the value is either `hcl_code` or `tf_plan`, depending on the type of scan desired.
## Usage
Ensure that the policy attached to the IAM role whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />
<br />Review the code including the [`terraform.yml`](./.github/workflows/terraform.yml) to understand the steps in the GitHub Actions pipeline. Also review the `terraform` code to understand all the concepts associated with creating an AWS VPC, subnets, internet gateway, route table, and route table association.
<br />If you want to check the pipeline logs, click on the **Build Badge** (terrform-infra-provisioning) above the image in this ReadMe.
## License
This code is released under the Unlincse License. See [LICENSE](LICENSE).