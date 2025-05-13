resource "aws_api_gateway_vpc_link" "this" {
  count       = var.enabled ? 1 : 0
  name        = var.vpclink_name
  description = var.vpclink_description
  target_arns = [var.target_arn]
  tags        = var.vpclink_tags
}

output "vpclink_id" {
  value       = try(aws_api_gateway_vpc_link.this[0].id, "none")
  description = "The ID of the VPC Link."
}

output "vpclink_name" {
  value       = try(aws_api_gateway_vpc_link.this[0].name, "none")
  description = "The name of the VPC Link."
}
