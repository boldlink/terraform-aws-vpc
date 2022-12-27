locals {
  create_nat = length(var.nat_gateway_ids) > 0 ? true : false
}
