###########
# API Key #
###########

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "api_key_name" {
  type        = string
  description = "The name of the API Key."
}

variable "api_key_description" {
  type        = string
  default     = ""
  description = "A description of the API Key."
}

variable "api_key_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the API Key can be leveraged by callers."
}

variable "api_key_value" {
  type        = string
  default     = null
  description = "The value of the API Key. If specified, the value must be an alphanumeric string between 20 and 128 characters."
}

variable "api_key_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to be assigned to the API Key."
}

##############
# Usage Plan #
##############

variable "usage_plan_name" {
  type        = string
  description = "The name of the Usage Plan."
}

variable "usage_plan_description" {
  type        = string
  default     = ""
  description = "A description of the Usage Plan."
}

variable "usage_plan_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to be assigned to the Usage Plan."
}

variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API."
}

variable "stage_name" {
  type        = string
  description = "The name of the Stage associated to the Usage Plan."
}

variable "usage_plan_throttle_path" {
  type        = string
  description = "Specify the path and the method to apply the throttle settings to."
}

variable "usage_plan_burst" {
  type        = number
  default     = 0
  description = "Enter the number of concurrent requests that a client can make to your API Gateway."
}

variable "usage_plan_rate" {
  type        = number
  default     = 0
  description = "Enter the rate of API requests per second that clients can call your API Gateway."
}

variable "limit" {
  type        = number
  default     = 0
  description = "Enter the total number of API requests that a user can make in the given time period."
}

variable "offset" {
  type        = number
  default     = 0
  description = "The number of API requests subtracted from the given limit in the initial time period."
}

variable "period" {
  type        = string
  default     = "DAY"
  description = "The time period in which the limit applies. Valid values are: DAY | WEEK | MONTH"
}

variable "burst_limit" {
  type        = number
  default     = 0
  description = "The API request burst limit."
}

variable "rate_limit" {
  type        = number
  default     = 0
  description = "The API request steady-state rate limit."
}

##################
# Usage Plan Key #
##################

variable "api_key_type" {
  type        = string
  default     = "API_KEY"
  description = "The type of a Usage Plan Key. Valid key type is API_KEY."
}
