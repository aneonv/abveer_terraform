module "vpc" {
  source = "./modules/vpc"

  cidr       = var.cidr
  cidr_sub1  = var.cidr_sub1
  cidr_sub2  = var.cidr_sub2

  tags = {
    project     = var.project_name
    environment = var.environment
  }
}

module "ec2_instance" {
  source               = "./modules/ec2_instance"
  ami_value            = var.ami_value
  instance_type_value  = var.instance_type_value
  subnet_id            = module.vpc.subnet_ids[0]
  key_name             = var.key_name

  tags = {
    project     = var.project_name
    environment = var.environment
  }
}
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project_name}-s3-bucket-1796"

  tags = {
    project     = var.project_name
    environment = var.environment
  }
  
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.project_name}-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    project     = var.project_name
    environment = var.environment
  }
  
}