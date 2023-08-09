output "subnet_ids" {
  description = "List of internal subnet IDs"
  value       = aws_subnet.internal[*].id
}
