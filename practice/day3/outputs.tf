output "instance-public-ip" {
  value = module.ec2_instance.public-ip-address
}
output "vpc-id" {
    value = module.vpc.vpc_id
  
}