output "vpc_id" {
    value = aws_vpc.my_vpc.id
  
}
output "sub1_id" {
    value = aws_subnet.pb_sub1.id
  
}
output "sub2_id" {
    value = aws_subnet.pb_sub2.id
}