##################
# Method Request #
##################

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API."
}

variable "resource_id" {
  type        = string
  description = "The ID of the API resource."
}

variable "http_method" {
  type        = string
  description = "The HTTP method. Valid values are: GET | POST | PUT | DELETE | HEAD | OPTIONS | ANY"
}

variable "authorization" {
  type        = string
  description = "The type of Authorization used for the API Gateway method. Valid values are: NONE | CUSTOM | AWS_IAM"
}

variable "authorizer_id" {
  type        = string
  default     = null
  description = "The ID of the Authorizer to be used when the authorization is CUSTOM."
}

variable "api_key_required" {
  type        = bool
  default     = false
  description = "A boolean flag that specifies whether or not the API method requires an API Key."
}

variable "request_validator_id" {
  type        = string
  default     = null
  description = "The ID of the Request Validator to be used for the API method."
}

variable "request_content_type" {
  type        = string
  default     = null
  description = "The content type of the Method Request body."
}

variable "request_model_name" {
  type        = string
  default     = null
  description = "The name of the API Gateway model to be used in the Method Request."
}

variable "request_parameters" {
  type        = map(string)
  default     = {}
  description = "A map of the Request Parameters (from the path, query string and headers) that must be passed to the Integration."
}

###################
# Method Response #
###################

variable "status_code" {
  type        = string
  description = "The status code for the Method Response."
}

variable "response_content_type" {
  type        = string
  default     = null
  description = "The content type of the Method Response body."
}

variable "response_model_name" {
  type        = string
  default     = null
  description = "The name of the API Gateway model to be used in the Method Response."
}

variable "response_parameters" {
  type        = map(string)
  default     = {}
  description = "A map of the Response Parameters that API Gateway can send back to the caller."
}
