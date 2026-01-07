#Create an instance
resource "aws_instance" "first_instance" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
  key_name      = "aws_login"
  }

