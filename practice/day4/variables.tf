variable "ami_id" {
    description = "The AMI ID for the EC2 instance"
    type        = string
  
}
variable "instance_type" {
    description = "The type of instance to use"
    type        = string
    default     = "t2.micro"
  
}
variable "key_name" {
    description = "The name of the key pair to use for the instance"
    type        = string
}
variable "instance_name" {
    description = "The base name for the EC2 instances"
    type        = string
}
variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}
variable "pb_sub1_cidr" {
    description = "The CIDR block for the public subnet 1"
    type        = string
}
variable "pb_sub2_cidr" {
    description = "The CIDR block for the public subnet 2"
    type        = string
  
}
variable "pr_sub1_cidr" {
    description = "The CIDR block for the private subnet 1"
    type        = string
  
}
variable "pr_sub2_cidr" {
    description = "The CIDR block for the private subnet 2"
    type        = string
  
}
variable "sub1_az" {
  description = "Availability zone for subnet 1"
  type        = string
}

variable "sub2_az" {
  description = "Availability zone for subnet 2"
  type        = string
}

variable "subnet1_name" {
  description = "Name tag for public subnet 1"
  type        = string
}

variable "subnet2_name" {
  description = "Name tag for public subnet 2"
  type        = string
}
