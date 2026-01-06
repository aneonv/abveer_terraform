output "public-ip-address" {
  value = aws_instance.my_instance.public_ip
}