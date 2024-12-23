resource "aws_subnet" "public_subnet" {

  count                                          = var.enabled && var.is_public ? 1 : 0
  vpc_id                                         = var.vpc_id
  cidr_block                                     = var.public_subnet_cidr
  assign_ipv6_address_on_creation                = var.assign_ipv6_address_on_creation
  availability_zone                              = var.availability_zone
  enable_dns64                                   = var.enable_dns64
  enable_resource_name_dns_a_record_on_launch    = var.enable_resource_name_dns_a_record_on_launch
  enable_resource_name_dns_aaaa_record_on_launch = var.enable_resource_name_dns_aaaa_record_on_launch
  ipv6_cidr_block                                = var.ipv6_cidr_block
  ipv6_native                                    = var.ipv6_native
  map_public_ip_on_launch                        = var.map_public_ip_on_launch
  private_dns_hostname_type_on_launch            = var.private_dns_hostname_type_on_launch
  tags                                           = merge(var.public_subnet_tags, { Name = var.public_subnet_name, VPC = var.vpc_id })

}

resource "aws_subnet" "private_subnet" {

  count                                          = var.enabled && (var.is_public || var.private_subnet_name != null) ? 1 : 0
  vpc_id                                         = var.vpc_id
  cidr_block                                     = var.private_subnet_cidr
  assign_ipv6_address_on_creation                = var.assign_ipv6_address_on_creation
  availability_zone                              = var.availability_zone
  enable_dns64                                   = var.enable_dns64
  enable_resource_name_dns_a_record_on_launch    = var.enable_resource_name_dns_a_record_on_launch
  enable_resource_name_dns_aaaa_record_on_launch = var.enable_resource_name_dns_aaaa_record_on_launch
  ipv6_cidr_block                                = var.ipv6_cidr_block
  ipv6_native                                    = var.ipv6_native
  map_public_ip_on_launch                        = var.map_public_ip_on_launch
  private_dns_hostname_type_on_launch            = var.private_dns_hostname_type_on_launch
  tags                                           = merge(var.private_subnet_tags, { Name = var.private_subnet_name, VPC = var.vpc_cidr })

}

# Create a Route Table association for the Public Route Table, only if you are creating a Public Subnet.
resource "aws_route_table_association" "associate_public_subnet" {

  count          = var.enabled && var.is_public ? 1 : 0
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = var.public_rt_id
  depends_on     = [aws_subnet.public_subnet]

}

resource "aws_route_table_association" "associate_private_subnet_existing_rt" {

  count          = var.enabled && !var.is_public ? 1 : 0
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = var.private_rt_id
  depends_on     = [aws_subnet.private_subnet]

}

resource "aws_route_table_association" "associate_private_subnet_new_rt" {

  count          = var.enabled && var.is_public ? 1 : 0
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
  depends_on     = [aws_route_table.private_rt]

}

resource "aws_eip" "natgw_eip" {

  count  = var.enabled && var.is_public && var.natgw_name != null ? 1 : 0
  domain = "vpc"
  tags   = merge(var.eip_tags, { Name = var.eip_name })

}

resource "aws_nat_gateway" "this" {

  count         = var.enabled && var.is_public && var.natgw_name != null ? 1 : 0
  subnet_id     = aws_subnet.public_subnet[count.index].id
  allocation_id = aws_eip.natgw_eip[count.index].id
  tags          = merge(var.natgw_tags, { Name = var.natgw_name })

  depends_on = [
    aws_subnet.public_subnet,
    aws_eip.natgw_eip
  ]

}

resource "aws_route_table" "private_rt" {

  count  = var.enabled && var.is_public && var.natgw_name != null ? 1 : 0
  vpc_id = var.vpc_id
  tags   = merge(var.private_rt_tags, { Name = var.private_rt_name })

  route {
    gateway_id = "local"
    cidr_block = var.vpc_cidr
  }

  dynamic "route" {
    for_each = var.natgw_name != null ? [1] : []

    content {
      nat_gateway_id = aws_nat_gateway.this[count.index].id
      cidr_block     = "0.0.0.0/0"
    }
  }

  dynamic "route" {
    for_each = var.virtual_private_gateways

    content {
      gateway_id = route.value.vgw_id
      cidr_block = route.value.cidr_block
    }
  }

  dynamic "route" {
    for_each = var.transit_gateways

    content {
      transit_gateway_id = route.value.tgw_id
      cidr_block         = route.value.cidr_block
    }
  }

  dynamic "route" {
    for_each = var.vpc_peering_connections

    content {
      vpc_peering_connection_id = route.value.pcx_id
      cidr_block                = route.value.cidr_block
    }
  }

  dynamic "route" {
    for_each = var.network_interfaces

    content {
      network_interface_id = route.value.eni_id
      cidr_block           = route.value.cidr_block
    }
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3_vpce" {
  count           = var.enabled && var.s3_gateway_endpoint != null ? 1 : 0
  vpc_endpoint_id = var.s3_gateway_endpoint
  route_table_id  = aws_route_table.private_rt[count.index].id
  depends_on      = [aws_route_table.private_rt]
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_vpce" {
  count           = var.enabled && var.dynamodb_gateway_endpoint != null ? 1 : 0
  vpc_endpoint_id = var.dynamodb_gateway_endpoint
  route_table_id  = aws_route_table.private_rt[count.index].id
  depends_on      = [aws_route_table.private_rt]
}