#########
# Model #
#########

variable "enabled" {
  type        = bool
  default     = true
  description = "A flag that indicates whether to create or decomission a resource. Set to True to create or False to decomission."
}

variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API."
}

variable "model_name" {
  type        = string
  description = "The name of the Model."
}

variable "model_description" {
  type        = string
  default     = ""
  description = "A description of the Model."
}

variable "model_schema" {
  type        = string
  description = "The schema of the Model in JSON format."
}

variable "content_type" {
  type        = string
  default     = "application/json"
  description = "The content type of the Model."
}
