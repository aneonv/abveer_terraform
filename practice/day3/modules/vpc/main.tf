resource "aws_vpc" "anan_vpc" {
  cidr_block = var.cidr

  tags = merge(
    var.tags,
    { Name = "${var.tags.project}-vpc" }
  )
}

resource "aws_subnet" "sub1" {
  vpc_id            = aws_vpc.anan_vpc.id
  cidr_block        = var.cidr_sub1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { Name = "${var.tags.project}-subnet1" }
  )
}

resource "aws_subnet" "sub2" {
  vpc_id            = aws_vpc.anan_vpc.id
  cidr_block        = var.cidr_sub2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    { Name = "${var.tags.project}-subnet2" }
  )
}
