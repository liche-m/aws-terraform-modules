######################
# Custom Domain Name #
######################

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API."
}

variable "stage_name" {
  type        = string
  description = "The name of the Stage to be associated with the Custom Domain Name."
}

variable "domain_name" {
  type        = string
  description = "The fully qualified Domain Name to register for API Gateway."
}

variable "endpoint" {
  type        = string
  default     = "REGIONAL"
  description = "The endpoint type. Valid values are EDGE or REGIONAL."
}

variable "certificate_arn" {
  type        = string
  description = "The ARN of the regional certificate issued by ACM."
}

variable "security_policy" {
  type        = string
  default     = "TLS_1_2"
  description = "The TLS version and Cipher Suite for the Domain Name. Valid values are TLS_1_0 and TLS_1_2."
}

variable "tags" {
  type        = map(string)
  description = "Tags to be assigned to the Custom Domain Name."

  default = {
    "ResourceType" = "CustomDomainName"
  }
}
