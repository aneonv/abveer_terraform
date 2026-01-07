output "vpc_id" {
  value = aws_vpc.anan_vpc.id
}

output "subnet_ids" {
  value = [aws_subnet.sub1.id, aws_subnet.sub2.id]
}
