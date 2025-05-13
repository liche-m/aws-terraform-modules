#####################
# Request Validator #
#####################

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API."
}

variable "request_validator_name" {
  type        = string
  description = "The name of the Request Validator."
}

variable "validate_request_body" {
  type        = bool
  default     = false
  description = "A boolean flag indicating whether to validate the Request Body. Defaults to False."
}

variable "validate_request_parameters" {
  type        = bool
  default     = false
  description = "A boolean flag indicating whether to validate the Request Parameters. Defaults to False."
}
