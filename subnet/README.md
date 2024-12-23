<!-- BEGIN_TF_DOCS -->

# AWS Subnet Module

Configuration in this directory creates an AWS Subnet and its associated dependencies.
Some notable constraints to be aware of when using this module:

<br>

**Reasons for creating a Public Subnet:**

- There is **NO** other Public Subnet in that particular Availability Zone.
  <br> **OR** <br>
- All the **Public Subnets** in the VPC have run out of **Public** IP addresses.

<br>

**Reasons for creating a NAT Gateway:**

- There is **NO** other Public Subnet in that particular Availability Zone.

<br>

**Reasons for creating an Elastic IP:**

- A *brand new* **NAT Gateway** is being created.

<br>

**Reasons for creating a Private Subnet:**

- A *brand new* **Public Subnet** is being created in an Availability Zone that does **NOT** have **ANY** Public and Private Subnets.
  <br> **OR** <br>
- All the **Private Subnets** in the VPC have run out of **Private** IP addresses.

<br>

**Reasons for creating a Route Table to be associated with the Private Subnet:**

- A **Public** and a **Private** Subnet is being created.
  <br> **AND** <br> 
- There is **NO** other ***Private*** Route Table for the VPC in this particular Availability Zone.

## Note:

- The usage for each type of Use Case is provided below.
- Some Test Cases can be found here: `tests/`

## Requirements

<br>

| Name | Version |
| ----------- | ----------- |
| terraform | >= 1.3.0 |
| aws | >= 5.54.1 |

## Resources

<br>

| Name | Type | Source |
| ----------- | ----------- | ----------- |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource | main.tf |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource | main.tf |
| [aws_route_table_association.associate_public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource | main.tf |
| [aws_route_table_association.associate_private_subnet_existing_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource | main.tf |
| [aws_route_table_association.associate_private_subnet_new_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource | main.tf |
| [aws_eip.natgw_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource | main.tf |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource | main.tf |
| [aws_route_table.private_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource | main.tf |
| [aws_vpc_endpoint_route_table_association.s3_vpce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource | main.tf |
| [aws_vpc_endpoint_route_table_association.dynamodb_vpce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource | main.tf |

## Subnet Inputs

<br>

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| <a name="vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the new Subnet will be created. | `string` | N/A | Yes |
| <a name="vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The IPv4 CIDR block for the VPC. | `string` | N/A | Yes |
| <a name="public_subnet_name"></a> [public\_subnet\_name](#input\_public\_subnet\_name) | The name of the new Public Subnet. | `string` | `null` | No |
| <a name="private_subnet_name"></a> [private\_subnet\_name](#input\_private\_subnet\_name) | The name of the new Private Subnet. | `string` | `null` | No |
| <a name="is_public"></a> [is\_public](#input\_is\_public) | Flag that indicates whether or not a Subnet is Public. Set to `true` if you intend on creating a Public Subnet. Set to `false` otherwise. | `bool` | `false` | Yes |
| <a name="public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | The IPv4 CIDR block for the new Public Subnet. | `string` | `null` | No |
| <a name="private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | The IPv4 CIDR block for the new Private Subnet. | `string` | `null` | No |
| <a name="assign_ipv6_address_on_creation"></a> [assign\_ipv6\_address\_on\_creation](#input\_assign\_ipv6\_address\_on\_creation) | Set to `true` if you want the ENIs (that will be created in the new Subnet) to have an IPv6 address. | `bool` | `false` | No |
| <a name="availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone for the new Subnet. | `string` | `null` | No |
| <a name="enable_dns64"></a> [enable\_dns64](#input\_enable\_dns64) | Indicates whether DNS queries made to the Amazon-provided DNS Resolver in the new Subnet should return synthetic IPv6 addresses for IPv4-only destinations. | `bool` | `false` | No |
| <a name="enable_resource_name_dns_a_record_on_launch"></a> [enable\_resource\_name\_dns\_a\_record\_on\_launch](#input\_enable\_resource\_name\_dns\_a\_record\_on\_launch) | Indicates whether to respond to DNS queries for instance hostnames with DNS A records. | `bool` | `false` | No |
| <a name="enable_resource_name_dns_aaaa_record_on_launch"></a> [enable\_resource\_name\_dns\_aaaa\_record\_on\_launch](#input\_enable\_resource\_name\_dns\_aaaa\_record\_on\_launch) | Indicates whether to respond to DNS queries for instance hostnames with DNS AAAA records. | `bool` | `false` | No |
| <a name="ipv6_cidr_block"></a> [ipv6\_cidr\_block](#input\_ipv6\_cidr\_block) | The IPv6 network range for the Subnet in CIDR notation. The Subnet size must use a /64 prefix length. | `string` | `null` | Yes |
| <a name="ipv6_native"></a> [ipv6\_native](#input\_ipv6\_native) | Indicates whether to create an IPv6-only Subnet. | `bool` | `false` | No |
| <a name="map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Set to `true` if you want instances that are launched in the new Subnet to be assigned a Public IP address. | `bool` | `false` | No |
| <a name="private_dns_hostname_type_on_launch"></a> [private\_dns\_hostname\_type\_on\_launch](#input\_private\_dns\_hostname\_type\_on\_launch) | The type of Hostnames to assign to instances in the new Subnet at launch. Valid values are `ip-name` or `resource-name`. | `string` | `ip-name` | No |
| <a name="public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | A map of tags to assign to the new Public Subnet. | `map(string)` | `{}` | No |
| <a name="private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | A map of tags to assign to the new Private Subnet. | `map(string)` | `{}` | No |

## Elastic IP Inputs

<br>

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| <a name="eip_name"></a> [eip\_name](#input\_eip\_name) | The name of the Elastic IP address you want to create. The EIP will be allocated to the NAT Gateway you need to create. | `string` | `null` | No |
| <a name="eip_tags"></a> [eip\_tags](#input\_eip\_tags) | A map of tags to assign to the Elastic IP address that will be allocated to the NAT Gateway. | `map(string)` | `{}` | No |
| <a name="natgw_name"></a> [natgw\_name](#input\_natgw\_name) | The name of the NAT Gateway you want to create. Only specify if you are creating a Public Subnet in an AZ that has **NO** existing Public Subnets. | `string` | `null` | No |
| <a name="natgw_tags"></a> [natgw\_tags](#input\_natgw\_tags) | A map of tags to assign to the NAT Gateway. | `map(string)` | `{}` | No |

## Private Route Table Inputs

<br>

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| <a name="public_rt_id"></a> [public\_rt\_id](#input\_public\_rt\_id) | The Route Table ID of the Public Route Table. Only specify this if you are creating a Public Subnet and a Route Table association. | `string` | `null` | No |
| <a name="private_rt_id"></a> [private\_rt\_id](#input\_private\_rt\_id) | The Route Table ID of the Private Route Table. Only specify this if you are creating a Private Subnet and a Route Table association. | `string` | `null` | No |
| <a name="private_rt_name"></a> [private\_rt\_name](#input\_private\_rt\_name) | The name of the Route Table you want to create. Only specify if you are creating the following: <br>  1. A Public Subnet in an AZ that has **NO** existing Public Subnets. <br>  2. A NAT Gateway. | `string` | `null` | No |
| <a name="private_rt_tags"></a> [private\_rt\_tags](#input\_private\_rt\_tags) | A map of tags to assign to the new Private Route Table. | `map(string)` | `{}` | No |

## Route Target Inputs

<br>

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| <a name="virtual_private_gateways"></a> [virtual\_private\_gateways](#input\_virtual\_private\_gateways) | A map of objects containing the ID of a Virtual Private Gateway and the associated destination CIDR block. | <pre>map(object({<br>    vgw_id     = string<br>    cidr_block = string<br>  }))</pre> | `{}` | No |
| <a name="transit_gateways"></a> [transit\_gateways](#input\_transit\_gateways) | A map of objects containing the ID of a Transit Gateway and the associated destination CIDR block. | <pre>map(object({<br>    tgw_id     = string<br>    cidr_block = string<br>  }))</pre> | `{}` | No |
| <a name="s3_gateway_endpoint"></a> [s3\_gateway\_endpoint](#input\_s3\_gateway\_endpoint) | The ID of the S3 Gateway VPC endpoint. | `string` | `null` | No |
| <a name="dynamodb_gateway_endpoint"></a> [s3\_dynamodb\_endpoint](#input\_dynamodb\_gateway\_endpoint) | The ID of the DynamoDB Gateway VPC endpoint. | `string` | `null` | No |
| <a name="vpc_peering_connections"></a> [vpc\_peering\_connections](#input\_vpc\_peering\_connections) | A map of objects containing the ID of a VPC Peering Connection and the associated destination CIDR block. | <pre>map(object({<br>    pcx_id     = string<br>    cidr_block = string<br>  }))</pre> | `{}` | No |
| <a name="network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | A map of objects containing the ID of an ENI and the associated destination CIDR block. | <pre>map(object({<br>    eni_id     = string<br>    cidr_block = string<br>  }))</pre> | `{}` | No |

## Usage

### Use Case 1:

This configuration creates a **brand new** Public and Private Subnet in an Availability Zone (`us-east-1c`) that has not been leveraged as yet. In addition:

- A **NAT Gateway** will be created and attached to the newly created **Public Subnet**.
- A **Route Table** will be created and associated with the newly created **Private Subnet**.

<br>

```hcl
module "use_case_1" {
  source = "../"
  is_public                 = true
  vpc_cidr                  = "172.31.0.0/16"
  vpc_id                    = "vpc-abc12345"
  public_subnet_name        = "dev-public-3"
  private_subnet_name       = "dev-private-3"
  public_subnet_cidr        = "172.31.48.0/20"
  private_subnet_cidr       = "172.31.64.0/20"
  availability_zone         = "us-east-1c"
  eip_name                  = "natgw-eip-us-east-1c"
  natgw_name                = "natgw-us-east-1c"
  public_rt_id              = "rtb-def12345"
  private_rt_name           = "dev-private-rt-3"
  s3_gateway_endpoint       = "vpce-123456789abcdefgh"
  dynamodb_gateway_endpoint = "vpce-987654321zxywvabc"

  vpc_peering_connections = {
    pcx_1 = {
      pcx_id     = "pcx-0bc13f7df27e46286"
      cidr_block = "172.30.0.0/16"
    },
    pcx_2 = {
      pcx_id     = "pcx-0dc13f7df27e57391"
      cidr_block = "10.0.0.0/16"
    }
  }

  public_subnet_tags = {
    Designation  = "Public",
    Resource     = "Subnet"
  }

  private_subnet_tags = {
    Designation  = "Private",
    Resource     = "Subnet"
  }

  eip_tags = {
    Resource     = "EIP"
  }

  natgw_tags = {
    Resource     = "NAT Gateway"
  }

  private_rt_tags = {
    Resource     = "Route Table"
  }
}
```

### Use Case 2:

This configuration creates a Private Subnet and associates it with an existing Route Table.

<br>

```hcl
module "use_case_2" {
  source = "../"
  is_public           = false
  vpc_cidr            = "10.0.0.0/16"
  vpc_id              = "vpc-123321123abdeabde"
  private_subnet_name = "dev-private-4"
  private_subnet_cidr = "10.0.8.0/24"
  availability_zone   = "eu-west-1c"
  private_rt_id       = "rtb-02e5499fdd5e57b4e"

  private_subnet_tags = {
    Designation  = "Private",
    Resource     = "Subnet"
  }  
}
```

<!-- END_TF_DOCS -->
