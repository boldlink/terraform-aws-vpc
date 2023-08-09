output "subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}
