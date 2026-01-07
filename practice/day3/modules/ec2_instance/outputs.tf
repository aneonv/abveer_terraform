output "public-ip-address" {
  value = aws_instance.first_instance.public_ip
}