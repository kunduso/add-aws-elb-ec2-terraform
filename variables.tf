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

variable "subnet_cidr_private" {
  description = "cidr blocks for the private subnets"
  default     = ["10.20.20.0/28", "10.20.20.16/28", "10.20.20.32/28"]
  type        = list(any)
}

variable "availability_zone" {
  description = "availability zones for the private subnets"
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
  type        = list(any)
}