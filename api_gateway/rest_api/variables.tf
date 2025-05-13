############
# REST API #
############

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "rest_api_name" {
  type        = string
  description = "The name of the REST API."
}

variable "rest_api_description" {
  type        = string
  default     = ""
  description = "The description for the REST API."
}

variable "api_key_source" {
  type        = string
  default     = "HEADER"
  description = "Source of the Api Key for requests. Valid values are HEADER and AUTHORIZER."
}

variable "binary_media_types" {
  type        = list(string)
  default     = []
  description = "List of binary media types supported by the REST API. By default, it only supports UTF-8-encoded text payloads."
}

variable "disable_default_api_endpoint" {
  type        = bool
  default     = false
  description = "A flag to indicate whether or not clients can call the REST API using the default endpoint."
}

variable "api_endpoint_type" {
  type        = string
  default     = "REGIONAL"
  description = "The API Gateway endpoint type. Valid values are REGIONAL, EDGE and PRIVATE."
}

variable "cloudwatch_role_arn" {
  type        = string
  description = "The ARN of the IAM Role to enable CloudWatch logging and monitoring."
}

variable "deployment_resources" {
  type        = set(string)
  default     = []
  description = "A list of resources that will trigger a new deployment of the API Gateway."
}

variable "deployment_description" {
  type        = string
  default     = ""
  description = "The description of the API Gateway deployment."
}

variable "policy" {
  type        = string
  default     = null
  description = "The Resource-Based Policy (in JSON format) for the API Gateway."
}

variable "create_policy" {
  type        = bool
  default     = false
  description = "A boolean flag that specifies whether to create or delete an existing Resource-Based Policy."
}
