# Amazon EventBridge Module

Configuration in this directory creates an Amazon EventBridge Rule and it's associated targets.

Some notable configurations to be aware of when using this module:
- Example

## Requirements

| Name | Version |
| ----------- | ----------- |
| terraform | >= 1.3.0 |
| aws | >= 4.40 |

<br>

## EventBridge Rule Inputs

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| app_name | The name of the application/service. This will be used to name the resources. | `string` | N/A | Yes |
| description | A description of the EventBridge Rule. | `string` | N/A | Yes |
| event_bus | The name or ARN of the Event Bus to associate with the EventBridge Rule. | `string` | `default` | No |
| schedule_expression | The schedule expression for the EventBridge Rule. For example: `cron(0 20 * * ? *)` or `rate(5 minutes)` | `string` | `""` | No |
| event_pattern | The event pattern described in a JSON object. At least one of **schedule_expression** or **event_pattern** is required. **Note:** The event pattern size [limit](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-quota.html) is 2048 characters by default. This is adjustable up to 4096 characters. | `string` | `null` | No |
| tags | The tags for the EventBridge Rule. | `map(string)` | `{}` | No |
| enabled | Feature flag to create or implicitly destroy resources. | `bool` | `true` | No |

<br>

## EventBridge Target Inputs

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| target_id | The unique target assignment ID. If not specified, AWS will generate a random, unique ID for each EventBridge target. | `string` | `null` | No |
| lambda_target | A list of the qualified/unqualified Lambda Function ARNs to use as EventBridge targets. | `list(string)` | `[]` | No |
| sns_target | A list of the SNS Topic ARNs to use as EventBridge targets. | `list(string)` | `[]` | No |
| sqs_target | A map containing SQS Queue ARNs, URLs and their respective Message Group ID (if applicable). | <pre>map(object({<br>    arn              = string<br>    queue_url        = optional(string)<br>    message_group_id = optional(string)<br>  }))</pre> | `{}` | No. The **message_group_id** is a required parameter for FIFO Queues. |

<br>

## ECS Target Inputs

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| task_definitions | A list of the Task Definition ARNs to use as EventBridge targets. | `list(string)` | `[]` | No. Only required if **ecs_clusters** is provided. |
| ecs_clusters | A list of the ECS Cluster ARNs with respect to the Task Definition ARNs. | `list(string)` | `[]` | No |
| capacity_provider_strategies | The capacity provider strategies to use for each Task Definition. The Launch Type and Capacity Provider Strategies are mutually exclusive. | <pre>list(list(object({<br>    base              = optional(number)<br>    capacity_provider = string<br>    weight            = optional(number)<br>  })))</pre> | <pre>[[{<br>    base              = null<br>    capacity_provider = null<br>    weight            = null<br>  }]]</pre> | No |
| set_provider_strategy | Set to True if you intend on specifying a Capacity Provider Strategy. | `list(bool)` | N/A | Yes |
| enable_ecs_managed_tags | Specifies whether to enable Amazon ECS managed tags for the Task(s). | `list(bool)` | `[]` | No. Set to `false` for each Task Definition if not specified. |
| enable_execute_command | Specifies whether to enable the execute command functionality for the containers in the Task. | `list(bool)` | `[]` | No. Set to `false` for each Task Definition if not specified. |
| launch_types | Specifies the Launch Type on which your Task is running. Valid values are EC2, FARGATE or EXTERNAL. The Launch Type and Capacity Provider Strategies are mutually exclusive. | `list(string)` | `[]` | No |
| network_configurations | Specifies the VPC Subnets and Security Groups associated with the Tasks, and whether a Public IP address is to be used. | <pre>list(object({<br>    assign_public_ip = optional(bool)<br>    security_groups  = optional(list(string))<br>    subnets          = optional(list(string))<br>  }))</pre> | N/A | Yes |
| platform_versions | Specifies the platform version for the Task. Only used if the Launch Type is FARGATE. | `list(string)` | `[]` | No. Set to `null` for each Task Definition if not specified. |
| propagate_tags | Specifies whether to propagate the tags from the Task Definition to the Task. Only valid value is TASK_DEFINITION. | `list(string)` | `[]` | No. Set to `TASK_DEFINITION` for each Task Definition if not specified. |
| task_counts | The number of Tasks to instantiate based on the Task Definitions. Defaults to 1 Task per Task Definition. | `list(number)` | `[]` | No. Set to `1` for each Task Definition if not specified. |
| ecs_tags | A map of tags to assign to the ECS resources. | `list(map(string))` | `[{}]` | No |

<br>

## Usage
