terraform {
  backend "s3" {
    bucket = "anan-s3-bucket-1796"
    key    = "anan/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "anan-terraform-locks"
  }
}
