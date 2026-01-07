 module "ec2" {
    source        = "./modules/ec2"
    ami           = var.ami
    instance_type = lookup(var.instance_type, var.workspace, "t3.micro")
    key_name      = var.key_name

    tags = {
        Name      = "${var.workspace}-ec2-instance"
        Workspace = var.workspace
    }
 }