#Define AWS Region
variable "region" {
  description = "Infrastructure region"
  type        = string
  default     = "us-east-2"
}
#Define IAM User Access Key
variable "access_key" {
  description = "The access_key that belongs to the IAM user"
  type        = string
  sensitive   = true
  default     = ""
}
#Define IAM User Secret Key
variable "secret_key" {
  description = "The secret_key that belongs to the IAM user"
  type        = string
  sensitive   = true
  default     = ""
}
variable "name" {
  description = "The name of the application."
  type        = string
  default     = "app-1"
}
variable "ami_name" {
  description = "The ami name of the image from where the instances will be created"
  default     = ["amzn2-ami-amd-hvm-2.0.20250220.0-x86_64-gp2"]
  type        = list(string)
}
variable "vpc_cidr" {
  description = "the vpc cidr"
  default     = "10.20.20.0/26"
}
variable "subnet_cidr_public" {
  description = "cidr blocks for the public subnets"
  default     = ["10.20.20.0/28", "10.20.20.16/28", "10.20.20.32/28"]
  type        = list(any)
}