output "outputs" {
  description = "Module outputs"
  value = [
    module.minimum_vpc.public_subnet_ids,
  ]
}
