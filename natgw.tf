resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.gw]
}
