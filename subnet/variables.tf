variable "enabled" {
  type        = bool
  default     = true
  description = "Flag that indicates whether or not to create a particular resource."
}

##########
# Subnet #
##########

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the new Subnet will be created."
}

variable "vpc_cidr" {
  type        = string
  description = "The IPv4 CIDR block for the VPC."
}

variable "public_subnet_name" {
  type        = string
  default     = null
  description = "The name of the new Public Subnet."
}

variable "private_subnet_name" {
  type        = string
  default     = null
  description = "The name of the new Private Subnet."
}

variable "is_public" {
  type        = bool
  default     = false
  description = "Flag that indicates whether or not a Subnet is Public. Set to True if you intend on creating a Public Subnet. Set to False otherwise."
}

variable "public_subnet_cidr" {
  type        = string
  default     = null
  description = "The IPv4 CIDR block for the new Public Subnet."
}

variable "private_subnet_cidr" {
  type        = string
  default     = null
  description = "The IPv4 CIDR block for the new Private Subnet."
}

variable "assign_ipv6_address_on_creation" {
  type        = bool
  default     = false
  description = "Set to True if you want the ENIs (that will be created in the new Subnet) to have an IPv6 address."
}

variable "availability_zone" {
  type        = string
  default     = null
  description = "The Availability Zone for the new Subnet."
}

variable "enable_dns64" {
  type        = bool
  default     = false
  description = "Indicates whether DNS queries made to the Amazon-provided DNS Resolver in the new Subnet should return synthetic IPv6 addresses for IPv4-only destinations."
}

variable "enable_resource_name_dns_a_record_on_launch" {
  type        = bool
  default     = false
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS A records."
}

variable "enable_resource_name_dns_aaaa_record_on_launch" {
  type        = bool
  default     = false
  description = "Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records."
}

variable "ipv6_cidr_block" {
  type        = string
  default     = null
  description = "The IPv6 network range for the Subnet in CIDR notation. The Subnet size must use a /64 prefix length."
}

variable "ipv6_native" {
  type        = bool
  default     = false
  description = "Indicates whether to create an IPv6-only Subnet."
}

variable "map_public_ip_on_launch" {
  type        = bool
  default     = false
  description = "Set to True if you want instances that are launched in the new Subnet to be assigned a Public IP address."
}

variable "private_dns_hostname_type_on_launch" {
  type        = string
  default     = "ip-name"
  description = "The type of Hostnames to assign to instances in the new Subnet at launch. Valid values are ip-name or resource-name."
}

variable "public_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the new Public Subnet."
}

variable "private_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the new Private Subnet."
}

##############
# Elastic IP #
##############

variable "eip_name" {
  type        = string
  default     = null
  description = "The name of the Elastic IP address you want to create. The EIP will be allocated to the NAT Gateway you need to create."
}

variable "eip_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the Elastic IP address that will be allocated to the NAT Gateway."
}

variable "natgw_name" {
  type        = string
  default     = null
  description = "The name of the NAT Gateway you want to create. Only specify if you are creating a Public Subnet in an AZ that has NO existing Public Subnets."
}

variable "natgw_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the NAT Gateway."
}

#######################
# Private Route Table #
#######################

variable "public_rt_id" {
  type        = string
  default     = null
  description = "The Route Table ID of the Public Route Table. Only specify this if you are creating a Public Subnet and a Route Table association."
}

variable "private_rt_id" {
  type        = string
  default     = null
  description = "The Route Table ID of the Private Route Table. Only specify this if you are creating a Private Subnet and a Route Table association."
}

variable "private_rt_name" {
  type        = string
  default     = null
  description = <<EOF
  "The name of the Route Table you want to create. Only specify if you are creating the following:
  1. A Public Subnet in an AZ that has NO existing Public Subnets.
  2. A NAT Gateway."
  EOF
}

variable "private_rt_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the new Private Route Table."
}

#################
# Route Targets #
#################

variable "virtual_private_gateways" {
  type = map(object({
    vgw_id     = string
    cidr_block = string
  }))
  default     = {}
  description = "A map of objects containing the ID of a Virtual Private Gateway and the associated destination CIDR block."
}

variable "transit_gateways" {
  type = map(object({
    tgw_id     = string
    cidr_block = string
  }))
  default     = {}
  description = "A map of objects containing the ID of a Transit Gateway and the associated destination CIDR block."
}

variable "s3_gateway_endpoint" {
  type        = string
  default     = null
  description = "The ID of the S3 Gateway VPC endpoint."
}

variable "dynamodb_gateway_endpoint" {
  type        = string
  default     = null
  description = "The ID of the DynamoDB Gateway VPC endpoint."
}

variable "vpc_peering_connections" {
  type = map(object({
    pcx_id     = string
    cidr_block = string
  }))
  default     = {}
  description = "A map of objects containing the ID of a VPC Peering Connection and the associated destination CIDR block."
}

variable "network_interfaces" {
  type = map(object({
    eni_id     = string
    cidr_block = string
  }))
  default     = {}
  description = "A map of objects containing the ID of an ENI and the associated destination CIDR block."
}