################################
## VPC Endpoint(s)
################################

resource "aws_security_group" "allow_443" {
  name        = "vpce.${local.vpc_name}.allow_443"
  description = "Allow VPC Endpoints SSL/TLS inbound traffic"
  vpc_id      = local.vpc_id

  ingress {
    description = "TLS from ${local.vpc_name} VPC Endpoints"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr_block]
    # ipv6_cidr_blocks = [var.ipv6_cidr_block]
  }
  tags = var.interface_endpoint_tags
}

resource "aws_vpc_endpoint" "interface" {
  count               = length(var.interface_endpoint_service_names) > 0 ? length(var.interface_endpoint_service_names) : 0
  vpc_id              = local.vpc_id
  service_name        = element(var.interface_endpoint_service_names, count.index)
  auto_accept         = var.interface_endpoint_auto_accept
  policy              = var.interface_endpoint_policy
  private_dns_enabled = var.interface_endpoint_private_dns_enabled
  route_table_ids     = var.interface_endpoint_route_table_ids
  subnet_ids          = var.interface_endpoint_subnet_ids
  security_group_ids  = [try(aws_security_group.allow_443.id)]
  vpc_endpoint_type   = "Interface"
  timeouts {
    create = lookup(var.interface_endpoint_timeouts, "create", "10m")
    update = lookup(var.interface_endpoint_timeouts, "update", "10m")
    delete = lookup(var.interface_endpoint_timeouts, "delete", "10m")
  }
  tags       = var.interface_endpoint_tags
  depends_on = [aws_security_group.allow_443]
}

resource "aws_vpc_endpoint" "gateway" {
  count               = length(var.gateway_endpoint_service_names) > 0 ? length(var.gateway_endpoint_service_names) : 0
  vpc_id              = local.vpc_id
  service_name        = element(var.gateway_endpoint_service_names, count.index)
  auto_accept         = var.gateway_endpoint_auto_accept
  policy              = var.gateway_endpoint_policy
  private_dns_enabled = var.gateway_endpoint_private_dns_enabled
  route_table_ids     = var.gateway_endpoint_route_table_ids
  subnet_ids          = var.gateway_endpoint_subnet_ids
  security_group_ids  = var.gateway_endpoint_security_group_ids
  vpc_endpoint_type   = "Gateway"
  timeouts {
    create = lookup(var.gateway_endpoint_timeouts, "create", "10m")
    update = lookup(var.gateway_endpoint_timeouts, "update", "10m")
    delete = lookup(var.gateway_endpoint_timeouts, "delete", "10m")
  }
  tags = var.gateway_endpoint_tags
}

######################################################################################################################
## aws_vpc_endpoint_connection_notification: Provides a VPC Endpoint connection notification resource.
## Connection notifications notify subscribers of VPC Endpoint events.
######################################################################################################################

resource "aws_vpc_endpoint_connection_notification" "main" {
  count                       = var.create_vpc_endpoint_service ? 1 : 0
  vpc_endpoint_service_id     = aws_vpc_endpoint_service.main[0].id
  connection_notification_arn = var.connection_notification_arn
  connection_events           = var.connection_events
}

######################################################################################################################
## aws_vpc_endpoint_service: Provides a VPC Endpoint Service resource. Service consumers can create an Interface
## VPC Endpoint to connect to the service.
######################################################################################################################

resource "aws_vpc_endpoint_service" "main" {
  count                      = var.create_vpc_endpoint_service ? 1 : 0
  acceptance_required        = var.endpoint_service_acceptance_required
  network_load_balancer_arns = var.endpoint_service_network_load_balancer_arns
  allowed_principals         = var.endpoint_service_allowed_principals
  gateway_load_balancer_arns = var.endpoint_service_gateway_load_balancer_arns
  private_dns_name           = var.endpoint_service_private_dns_name
}

######################################################################################################################
## aws_vpc_endpoint_service_allowed_principal: Provides a resource to allow a principal to discover a
## VPC endpoint service.
######################################################################################################################

resource "aws_vpc_endpoint_service_allowed_principal" "main" {
  count                   = var.create_vpc_endpoint_service ? 1 : 0
  vpc_endpoint_service_id = aws_vpc_endpoint_service.main[0].id
  principal_arn           = var.endpoint_service_allowed_principal_arn
}

resource "aws_vpc_endpoint" "gatewayloadbalancer" {
  count               = var.create_gatewayloadbalancer_endpoint ? 1 : 0
  vpc_id              = local.vpc_id
  service_name        = aws_vpc_endpoint_service.main[0].service_name
  auto_accept         = var.gatewayloadbalancer_endpoint_auto_accept
  policy              = var.gatewayloadbalancer_endpoint_policy
  private_dns_enabled = var.gatewayloadbalancer_endpoint_private_dns_enabled
  route_table_ids     = var.gatewayloadbalancer_endpoint_route_table_ids
  subnet_ids          = var.gatewayloadbalancer_endpoint_subnet_ids
  security_group_ids  = var.gatewayloadbalancer_endpoint_security_group_ids
  vpc_endpoint_type   = "GatewayLoadBalancer"
  timeouts {
    create = lookup(var.gatewayloadbalancer_endpoint_timeouts, "create", "10m")
    update = lookup(var.gatewayloadbalancer_endpoint_timeouts, "update", "10m")
    delete = lookup(var.gatewayloadbalancer_endpoint_timeouts, "delete", "10m")
  }
  tags = var.gatewayloadbalancer_endpoint_tags
}
