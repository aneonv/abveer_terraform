variable "region" {
    description = "AWS region to deploy resources"
    type        = string
  
}
variable "ami" {
    description = "AMI ID for the EC2 instance"
    type        = string
  
}
variable "instance_type" {
    description = "Instance type for the EC2 instance"
    type        = map(string)
    default = {
      "dev" = "t3.micro"
      "stage" = "t3.medium"
    }

}
variable "key_name" {
    description = "Key pair name for the EC2 instance"
    type        = string
  
}
variable "workspace" {
    description = "The name of the current workspace"
    type        = string
}