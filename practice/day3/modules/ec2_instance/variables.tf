#variables
variable "tags" {
  type = map(string)
}
variable "ami_value" {
    description = "EC2 AMI ID"
    type        = string
  
}

variable "instance_type_value" {
    description = "EC2 instance type"
    type        = string
}

variable "subnet_id" {
  type = string
}
variable "key_name" {
  type = string
}