resource "aws_instance" "my_inst1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id1
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.instance_name}-1"
  }
}

resource "aws_instance" "my_inst2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id1
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.instance_name}-2"
  }
}