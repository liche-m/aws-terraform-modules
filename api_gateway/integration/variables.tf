#######################
# Integration Request #
#######################

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
  description = "The HTTP method when calling the associated API resource. Valid values are: GET | POST | PUT | DELETE | HEAD | OPTIONS | ANY"
}

variable "integration_http_method" {
  type        = string
  default     = null
  description = "Specifies how API Gateway interacts with the back-end. Required if type is HTTP, AWS, HTTP_PROXY or AWS_PROXY. Valid values are: GET | POST | PUT | DELETE | HEAD | OPTIONS | ANY | PATCH"
}

variable "type" {
  type        = string
  description = "Specifies the type of the Integration. Valid values are: HTTP | AWS | MOCK | HTTP_PROXY | AWS_PROXY"
}

variable "connection_type" {
  type        = string
  description = "The type of network connection to the Integration endpoint. Valid values are: INTERNET | VPC_LINK"
}

variable "connection_id" {
  type        = string
  default     = null
  description = "The ID of the VPC Link used for the Integration. Required if connection_type is VPC_LINK."
}

variable "integration_uri" {
  type        = string
  default     = null
  description = "The URI of the Integration endpoint. Required if type is HTTP, AWS, HTTP_PROXY or AWS_PROXY."
}

variable "credentials" {
  type        = string
  default     = null
  description = "Specify the ARN of an IAM Role or User for the API Gateway to assume when interacting with the Integration endpoint."
}

variable "passthrough_behaviour" {
  type        = string
  default     = null
  description = "Specifies how incoming requests are handled based on the Content-Type header in the request and the Request Templates in the Integration resource. Valid values are: WHEN_NO_MATCH | WHEN_NO_TEMPLATES | NEVER"
}

variable "req_content_handling" {
  type        = string
  default     = null
  description = "Specifies how to handle request payload content-type conversions. Valid values are: CONVERT_TO_BINARY | CONVERT_TO_TEXT"
}

variable "timeout_milliseconds" {
  type        = number
  default     = 29000
  description = "Custom timeout between 50 and 300 000 milliseconds."
}

variable "request_templates" {
  type        = map(string)
  default     = {}
  description = "A map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client."
}

variable "request_parameters" {
  type        = map(string)
  default     = {}
  description = "A map of the Request Parameters that are passed from the Method Request to the back-end."
}

variable "skip_cert_verification" {
  type        = bool
  default     = false
  description = "Specifies whether or not API Gateway skips verification that the certificate for an Integration endpoint is issued by a supported CA."
}

variable "cache_namespace" {
  type        = string
  default     = null
  description = "Specifies a group of related cached parameters."
}

variable "cache_key_parameters" {
  type        = list(string)
  default     = []
  description = "A list of Request Parameters that API Gateway caches. These parameters must also be defined in the Method Request Parameters."
}

########################
# Integration Response #
########################

variable "status_code" {
  type        = string
  description = "Specifies the Status Code that is used to map the Integration Response to an existing Method Response."
}

variable "resp_content_handling" {
  type        = string
  default     = null
  description = "Specifies how to handle response payload content-type conversions. Valid values are: CONVERT_TO_BINARY | CONVERT_TO_TEXT"
}

variable "response_templates" {
  type        = map(string)
  default     = {}
  description = "A map of templates used to transform the Integration Response body."
}

variable "response_parameters" {
  type        = map(string)
  default     = {}
  description = "A map of the Response Parameters that are passed from the back-end to the Method Request."
}

variable "selection_pattern" {
  type        = string
  default     = null
  description = "A regular expression pattern used to choose an Integration Response based on the back-end response."
}
