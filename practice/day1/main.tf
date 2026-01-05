provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"
  subnet_id = "subnet-07ec3d8ba8b689a7b"
  key_name = "aws_login"

}