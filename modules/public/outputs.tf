output "subnets" {
  description = "Output all subnet information"
  value       = aws_subnet.public.*
}
