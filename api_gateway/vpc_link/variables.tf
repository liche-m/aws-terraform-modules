############
# VPC Link #
############

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "vpclink_name" {
  type        = string
  description = "The name of the VPC Link."
}

variable "vpclink_description" {
  type        = string
  default     = ""
  description = "A description of the VPC Link."
}

variable "target_arn" {
  type        = string
  description = "The ARN of the Network Load Balancer (NLB) in the VPC targeted by the VPC Link."
}

variable "vpclink_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the VPC Link."
}
