resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "pb_sub1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pb_sub1_cidr
  availability_zone = var.sub1_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet1_name
  }
}

resource "aws_subnet" "pb_sub2" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.pb_sub2_cidr
    availability_zone = var.sub2_az
    map_public_ip_on_launch = true
    
    tags = {
        Name = var.subnet2_name
    }
  
}
resource "aws_subnet" "pr_sub1" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.pr_sub1_cidr
    availability_zone = var.sub1_az
    
    tags = {
        Name = "private-${var.subnet1_name}"
    }
  
}
resource "aws_subnet" "pr_sub2" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.pr_sub2_cidr
    availability_zone = var.sub2_az
    
    tags = {
        Name = "private-${var.subnet2_name}"
    }
  
}