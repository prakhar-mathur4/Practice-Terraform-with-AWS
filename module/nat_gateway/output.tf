output "nat_gateway_id" {
  value = aws_nat_gateway.main.id
}

output "eip_id" {
  value = aws_eip.nat.id
}