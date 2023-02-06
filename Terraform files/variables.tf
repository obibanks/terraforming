
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Region for AWS resource"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Base CIDR Block for VPC"
}

variable "dns_hostname" {
  type        = bool
  default     = true
  description = "Enable DNS Hostname for VPC"
}

variable "vpc_subnet_count" {
  type        = number
  description = "Number of subnets to create in VPC"
  default     = 3
}

variable "public_ip_launch" {
  type        = bool
  default     = true
  description = "Map public IP address for subnets on launch"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "TYpe of EC2 Instance"
}

variable "instance_count" {
  type        = number
  description = "Number of instances to create in VPC"
  default     = 3
}

