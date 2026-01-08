variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
  
}
variable "pb_sub1_cidr" {
    description = "The CIDR block for subnet 1"
    type        = string
  
}
variable "pr_sub1_cidr" {
    description = "The CIDR block for private subnet 1"
    type        = string
  
}
variable "sub1_az" {
    description = "The availability zone for subnet 1"
    type        = string
}
variable "subnet1_name" {
    description = "The name tag for subnet 1"
    type        = string
}
variable "pb_sub2_cidr" {
    description = "The CIDR block for subnet 2"
    type        = string
  
}
variable "pr_sub2_cidr" {
    description = "The CIDR block for private subnet 2"
    type        = string
  
}
variable "sub2_az" {
    description = "The availability zone for subnet 2"
    type        = string
}
variable "subnet2_name" {
    description = "The name tag for subnet 2"
    type        = string
}