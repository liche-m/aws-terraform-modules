##############
# Authorizer #
##############

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API."
}

variable "authorizer_name" {
  type        = string
  description = "The name of the Authorizer."
}

variable "authorizer_type" {
  type        = string
  description = "The type of the Authorizer. Possible values are TOKEN or REQUEST."
}

variable "authorizer_uri" {
  type        = string
  default     = null
  description = "Required for Authorizer Type: TOKEN or REQUEST. This must be a well formed Lambda Function URI in the form of: arn:aws:apigateway:{region}:lambda:path/{service_api}"
}

variable "authorizer_result_ttl" {
  type        = number
  default     = 0
  description = "The TTL of the cached Authorizer results in seconds."
}

variable "iam_role" {
  type        = string
  default     = null
  description = "The ARN of the IAM Role for the API Gateway to assume."
}

variable "identity_sources" {
  type        = string
  default     = "method.request.header.Authorization"
  description = "A comma-separated list of identity sources for a REQUEST type Lambda Authorizer (e.g. Headers, Query String Parameters, Stage Variables)."
}
