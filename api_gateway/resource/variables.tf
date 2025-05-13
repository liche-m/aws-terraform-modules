############
# Resource #
############

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API."
}

variable "parent_id" {
  type        = string
  description = "The ID of the parent API resource."
}

variable "path_part" {
  type        = string
  description = "The last path segment of this API resource."
}
