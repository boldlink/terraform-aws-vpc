output "outputs" {
  description = "Module outputs"
  value = [
    module.complete_vpc,
  ]
}

output "subnets_ids" {
  description = "Public Subnets outputs"
  value = {
    public = module.complete_vpc.public_subnet_ids
    private = module.complete_vpc.private_subnet_ids
    internal = module.complete_vpc.internal_subnet_ids
  }
}

output "route_table_ids" {
  description = "Public Route Tables outputs"
  value = {
    public = module.complete_vpc.public_route_table_ids
    private = module.complete_vpc.private_route_table_ids
    internal = module.complete_vpc.internal_route_table_ids
  }
}