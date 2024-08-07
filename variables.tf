variable "app_name" {
  type        = string
  description = "The name of the application/service."
}

variable "description" {
  type        = string
  description = "A description of the EventBridge Rule."
}

variable "event_bus" {
  type        = string
  default     = "default"
  description = "The name or ARN of the Event Bus to associate with the EventBridge Rule."
}

variable "schedule_expression" {
  type        = string
  default     = ""
  description = "The schedule expression for the EventBridge Rule. For example: cron(0 20 * * ? *) or rate(5 minutes)"
}

variable "event_pattern" {
  type        = string
  default     = null
  description = "The event pattern described in a JSON object."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags for the EventBridge Rule."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Feature flag to create or destroy resources."
}

#######################
# EventBridge Targets #
#######################

variable "target_id" {
  type        = string
  default     = null
  description = "A unique target assignment ID."
}

variable "lambda_target" {
  type        = list(string)
  default     = []
  description = "A list of the qualified/unqualified Lambda Function ARNs to use as EventBridge targets."
}

variable "sns_target" {
  type        = list(string)
  default     = []
  description = "A list of the SNS Topic ARNs to use as EventBridge targets."
}

variable "sqs_target" {
  type = map(object({
    arn              = string
    queue_url        = optional(string)
    message_group_id = optional(string)
  }))
  default     = {}
  description = "A map containing SQS Queue ARNs, URLs and their respective Message Group ID (if applicable)."
}

#######
# ECS #
#######

variable "task_definitions" {
  type        = list(string)
  default     = []
  description = "A list of the Task Definition ARNs to use as EventBridge targets."
}

variable "ecs_clusters" {
  type        = list(string)
  default     = []
  description = "A list of the ECS Cluster ARNs with respect to the Task Definition ARNs."
}

variable "capacity_provider_strategies" {
  type = list(list(object({
    base              = optional(number)
    capacity_provider = string
    weight            = optional(number)
  })))

  default = [[{
    base              = null
    capacity_provider = null
    weight            = null

  }]]

  description = "The capacity provider strategies to use for each Task Definition."
}

variable "set_provider_strategy" {
  type        = list(bool)
  description = "Set to True if you intend on specifying a Capacity Provider Strategy."
  default     = []
}

variable "enable_ecs_managed_tags" {
  type        = list(bool)
  default     = []
  description = "Specifies whether to enable Amazon ECS managed tags for the Task(s)."
}

variable "enable_execute_command" {
  type        = list(bool)
  default     = []
  description = "Specifies whether to enable the execute command functionality for the containers in the Task."
}

variable "launch_types" {
  type        = list(string)
  default     = []
  description = "Specifies the Launch Type on which your Task is running. Valid values are EC2, FARGATE or EXTERNAL."
}

variable "network_configurations" {
  type = list(object({
    assign_public_ip = optional(bool)
    security_groups  = optional(list(string))
    subnets          = optional(list(string))
  }))

  default = [{
    assign_public_ip = false
    security_groups  = []
    subnets          = []
  }]

  description = "Specifies the VPC Subnets and Security Groups associated with the Tasks, and whether a Public IP address is to be used."
}

variable "platform_versions" {
  type        = list(string)
  default     = []
  description = "Specifies the platform version for the Task. Only used if the Launch Type is FARGATE."
}

variable "propagate_tags" {
  type        = list(string)
  default     = []
  description = "Specifies whether to propagate the tags from the Task Definition to the Task. Only valid value is TASK_DEFINITION."
}

variable "task_counts" {
  type        = list(number)
  default     = []
  description = "The number of Tasks to instantiate based on the Task Definitions. Defaults to 1 Task per Task Definition."
}

variable "ecs_tags" {
  type        = list(map(string))
  default     = [{}]
  description = "A map of tags to assign to the ECS resources."
}