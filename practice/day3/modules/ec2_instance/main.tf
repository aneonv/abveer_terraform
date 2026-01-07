resource "aws_instance" "anan_instance" {
  ami           = var.ami_value
  instance_type = var.instance_type_value
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  tags = merge(
    var.tags,
    {
      Name = "${var.tags.project}-ec2_instance"
    }
  )
}
