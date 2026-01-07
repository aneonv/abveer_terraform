resource "aws_vpc" "first_vpc" {
  cidr_block = var.cidr
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.first_vpc.id
  cidr_block = var.cidr_sub1
  availability_zone = "us-east-1a"

}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.first_vpc.id
  cidr_block = var.cidr_sub2
  availability_zone = "us-east-1b"
}