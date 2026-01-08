output "instance_ips" {
  value = [
    aws_instance.my_inst1.public_ip,
    aws_instance.my_inst2.public_ip
  ]
}