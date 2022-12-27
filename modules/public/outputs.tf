output "subnets" {
  description = "Output all subnet information"
  value       = aws_subnet.public.*
}

output "nat_gateway_ids" {
  description = "Output all natGW information"
  value       = join("", aws_nat_gateway.single.*.id, aws_nat_gateway.multi[*].id)
}
