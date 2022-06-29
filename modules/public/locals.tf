locals {
  set_nat_single = var.nat == "single" ? true : null
  set_nat_multi  = var.nat == "multi" ? true : null
}
