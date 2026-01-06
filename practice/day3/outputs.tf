output "instance-public-ip" {
  value = module.ec2_instance.public-ip-address
}