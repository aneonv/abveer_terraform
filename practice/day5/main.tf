resource "aws_key_pair" "anan_key" {
  key_name   = "anan-key"  # name that will appear in AWS
  public_key = file("~/.ssh/anan_key.pub")
}
resource "aws_vpc" "uptown_vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "uptown-vpc"
  }
  
}
resource "aws_subnet" "uptown_subnet1" {
  vpc_id     = aws_vpc.uptown_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "uptown-subnet1"
  }
}
resource "aws_internet_gateway" "uptown_igw" {
  vpc_id = aws_vpc.uptown_vpc.id

  tags = {
    Name = "uptown-igw"
  }
}
resource "aws_route_table" "uptown_rt" {
  vpc_id = aws_vpc.uptown_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.uptown_igw.id
    }
    tags = {
        Name = "uptown-route-table"
    }
}
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.uptown_subnet1.id
  route_table_id = aws_route_table.uptown_rt.id
}
resource "aws_security_group" "uptown_sg" {
  name   = "sg"
  vpc_id = aws_vpc.uptown_vpc.id
    ingress {
        description = "HTTP from VPC"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
}
    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
        description = "Flask"
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
}
    egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "uptown-sg"
}
}

resource "aws_instance" "uptown_instance" {
  ami           = "resolve:ssm:/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.uptown_sg.id]
  subnet_id              = aws_subnet.uptown_subnet1.id
  key_name               = aws_key_pair.anan_key.key_name
  
  connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("~/.ssh/anan_key")
        host        = self.public_ip
    }
  provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py"
    }
  provisioner "remote-exec" {
  inline = [
    "echo 'Hello from remote instance...'",
    "sudo apt update -y",
    "sudo apt-get install -y python3-pip",
    "cd /home/ubuntu",
    "sudo pip3 install flask",
    "nohup sudo python3 app.py > app.log 2>&1 &",
  ]

    }
    tags = {
        Name = "uptown-instance"
  }
}