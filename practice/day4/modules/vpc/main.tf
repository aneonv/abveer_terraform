resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "my_vpc"
  }
}

# -------------------------
# Public Subnets
# -------------------------
resource "aws_subnet" "pb_sub1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pb_sub1_cidr
  availability_zone       = var.sub1_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet1_name
  }
}

resource "aws_subnet" "pb_sub2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pb_sub2_cidr
  availability_zone       = var.sub2_az
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet2_name
  }
}

# -------------------------
# Private Subnets
# -------------------------
resource "aws_subnet" "pr_sub1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.pr_sub1_cidr
  availability_zone = var.sub1_az

  tags = {
    Name = "private-${var.subnet1_name}"
  }
}

resource "aws_subnet" "pr_sub2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.pr_sub2_cidr
  availability_zone = var.sub2_az

  tags = {
    Name = "private-${var.subnet2_name}"
  }
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_internet_gateway"
  }
}

# -------------------------
# Public Route Table
# -------------------------
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "sub1_assoc" {
  subnet_id      = aws_subnet.pb_sub1.id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_route_table_association" "sub2_assoc" {
  subnet_id      = aws_subnet.pb_sub2.id
  route_table_id = aws_route_table.my_rt.id
}

# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "my_sg" {
  name        = "allow_ssh_http"
  description = "Security group to allow SSH and HTTP"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}