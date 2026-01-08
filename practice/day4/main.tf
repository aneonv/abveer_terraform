module "vpc_ws" {
  source = "./modules/vpc_ws"

  vpc_cidr     = var.vpc_cidr
  pb_sub1_cidr = var.pb_sub1_cidr
  pb_sub2_cidr = var.pb_sub2_cidr
  pr_sub1_cidr = var.pr_sub1_cidr
  pr_sub2_cidr = var.pr_sub2_cidr
  sub1_az      = var.sub1_az
  sub2_az      = var.sub2_az
  subnet1_name = var.subnet1_name
  subnet2_name = var.subnet2_name
}
module "ec2_webserver1" {
  source = "./modules/ec2_webserver"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  instance_name = var.instance_name

  subnet_id1         = module.vpc_ws.sub1_id
  security_group_ids = [module.vpc_ws.security_group_id]
}
