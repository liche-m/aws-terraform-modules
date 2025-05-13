# Amazon EventBridge Module

Configuration in this directory creates an Amazon EventBridge Rule and its associated targets.

Some notable configurations to be aware of when using this module:

```
Lambda Functions
SNS Topics
SQS Queues
ECS Task Definitions
```

The usage for each type of event target is provided below. Kindly view the usage for the event target you intend on configuring, prior to using this module.

<br>

## Requirements

<br>

| Name | Version |
| ----------- | ----------- |
| terraform | >= 1.9.8 |
| aws | >= 5.94.1 |

<br>

## Resources

<br>

| Name | Type | Source |
| ----------- | ----------- | ----------- |
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource | main.tf |
| [aws_cloudwatch_event_target.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource | main.tf |
| [aws_cloudwatch_event_target.sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource | main.tf |
| [aws_cloudwatch_event_target.sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target#sqs_target) | resource | main.tf |
| [aws_lambda_permission.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource | main.tf |
| [aws_cloudwatch_event_target.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target#ecs_target) | resource | main.tf |
| [aws_iam_role.eventbridge_role.eventbridge_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource | iam.tf |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source | iam.tf |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource | iam.tf |
| [aws_iam_role_policy_attachment.policy_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource | iam.tf |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource | iam.tf |

<br>

## EventBridge Rule Inputs

<br>

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| app_name | The name of the application/service. This will be used to name the resources. | `string` | N/A | Yes |
| description | A description of the EventBridge Rule. | `string` | N/A | Yes |
| event_bus | The name or ARN of the Event Bus to associate with the EventBridge Rule. | `string` | `default` | No |
| schedule_expression | The schedule expression for the EventBridge Rule. For example: `cron(0 20 * * ? *)` or `rate(5 minutes)` | `string` | `""` | No |
| event_pattern | The event pattern described in a JSON object. At least one of `schedule_expression` or `event_pattern` is required. <br><br> **NOTE:** The event pattern size [limit](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-quota.html) is 2048 characters by default. This is adjustable up to 4096 characters. | `string` | `null` | No |
| tags | The tags for the EventBridge Rule. | `map(string)` | `{}` | No |
| enabled | Feature flag to create or implicitly destroy resources. | `bool` | `true` | No |

<br>

## EventBridge Target Inputs

<br>

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| target_id | The unique target assignment ID. If not specified, AWS will generate a random, unique ID for each EventBridge target. <br><br> **NOTE:** Do not specify the `target_id` parameter when configuring multiple event targets. | `string` | `null` | No |
| lambda_target | A list of the qualified/unqualified Lambda Function ARNs to use as EventBridge targets. | `list(string)` | `[]` | No |
| sns_target | A list of the SNS Topic ARNs to use as EventBridge targets. | `list(string)` | `[]` | No |
| sqs_target | A map containing SQS Queue ARNs, URLs and their respective Message Group ID (if applicable). <br><br> **NOTE:** The `message_group_id` is a required parameter for FIFO Queues. | <pre>map(object({<br>    arn              = string<br>    queue_url        = optional(string)<br>    message_group_id = optional(string)<br>  }))</pre> | `{}` | No |

<br>

## ECS Target Inputs

<br>

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| task_definitions | A list of the Task Definition ARNs to use as EventBridge targets. | `list(string)` | `[]` | No |
| ecs_clusters | A list of the ECS Cluster ARNs with respect to the Task Definition ARNs. <br><br> **NOTE:** This is a required parameter if Task Definition ARNs are specified. | `list(string)` | `[]` | No |
| capacity_provider_strategies | The capacity provider strategies to use for each Task Definition. The Launch Type and Capacity Provider Strategies are mutually exclusive. | <pre>list(list(object({<br>    base              = optional(number)<br>    capacity_provider = string<br>    weight            = optional(number)<br>  })))</pre> | <pre>[[{<br>    base              = null<br>    capacity_provider = null<br>    weight            = null<br>  }]]</pre> | No |
| set_provider_strategy | Set to `true` if you intend on specifying a Capacity Provider Strategy. Set to `false` otherwise. | `list(bool)` | N/A | Yes |
| enable_ecs_managed_tags | Specifies whether to enable Amazon ECS managed tags for the Task(s). <br><br> **NOTE:** This is set to `false` for each Task Definition *(by default)* if not specified.| `list(bool)` | `[]` | No |
| enable_execute_command | Specifies whether to enable the execute command functionality for the containers in the Task. <br><br> **NOTE:** This is set to `false` for each Task Definition *(by default)* if not specified. | `list(bool)` | `[]` | No |
| launch_types | Specifies the Launch Type on which your Task is running. Valid values are EC2, FARGATE or EXTERNAL. The Launch Type and Capacity Provider Strategies are mutually exclusive. | `list(string)` | `[]` | No |
| network_configurations | Specifies the VPC Subnets and Security Groups associated with the Tasks, and whether a Public IP address is to be used. | <pre>list(object({<br>    assign_public_ip = optional(bool)<br>    security_groups  = optional(list(string))<br>    subnets          = optional(list(string))<br>  }))</pre> | N/A | Yes |
| platform_versions | Specifies the platform version for the Task. Only used if the Launch Type is FARGATE. <br><br> **NOTE:** This is set to `null` for each Task Definition *(by default)* if not specified. | `list(string)` | `[]` | No |
| propagate_tags | Specifies whether to propagate the tags from the Task Definition to the Task. Only valid value is TASK_DEFINITION. <br><br> **NOTE:** This is set to `TASK_DEFINITION` for each Task Definition *(by default)* if not specified. | `list(string)` | `[]` | No |
| task_counts | The number of Tasks to instantiate based on the Task Definitions. <br><br> **NOTE:** This is set to 1 Task per Task Definition by default. | `list(number)` | `[]` | No |
| ecs_tags | A map of tags to assign to the ECS resources. | `list(map(string))` | `[{}]` | No |

<br>

## Usage

<br>

Creates an EventBridge Rule that is based on an Event Pattern, with 5 Lambda Functions as event targets. A Resource-Based Policy statement is also added to each Lambda Function in the list below.

```hcl
module "five_lambdas_event_pattern" {
  source        = "../"
  app_name      = "lambda-targets"
  description   = "Based on an Event Pattern. Five Lambda Functions as event targets."
  event_pattern = <<PATTERN
  {
    "source": ["aws.autoscaling"],
    "detail-type": ["EC2 Instance Launch Successful", "EC2 Instance Launch Unsuccessful"],
    "detail": {
        "AutoScalingGroupName": ["asg-1", "asg-2", "asg-3", "asg-4"]
    }
  }
  PATTERN
  tags = {
    DevOpsEngineer = "Liche"
  }

  lambda_target = [
    "arn:aws:lambda:<aws_region>:<account_id>:function:<lambda_function_1>",
    "arn:aws:lambda:<aws_region>:<account_id>:function:<lambda_function_2>",
    "arn:aws:lambda:<aws_region>:<account_id>:function:<lambda_function_3>",
    "arn:aws:lambda:<aws_region>:<account_id>:function:<lambda_function_4>",
    "arn:aws:lambda:<aws_region>:<account_id>:function:<lambda_function_5>"
  ]
}
```

<br>

Creates an EventBridge Rule that is based on a Schedule Expression `rate(5 minutes)` with 3 SNS Topics as event targets.

```hcl
module "three_sns_topics_rate" {
  source              = "../"
  app_name            = "sns-targets"
  description         = "Based on a Schedule Expression: rate(5 minutes). Three SNS Topics as event targets."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }

  sns_target = [
    "arn:aws:sns:<aws_region>:<account_id>:<sns_topic_1>",
    "arn:aws:sns:<aws_region>:<account_id>:<sns_topic_2>",
    "arn:aws:sns:<aws_region>:<account_id>:<sns_topic_3>"
  ]
}
```

<br>

Creates an EventBridge Rule that is based on a Schedule Expression `cron(0 20 * * ? *)` with 1 FIFO Queue as an event target.

```hcl
module "one_fifo_sqs_cron" {
  source              = "../"
  app_name            = "fifo-sqs-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). One SNS Topic as an event target."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "fifo-sqs-target-test"
  sqs_target = {
    "queue1" = {
      arn              = "arn:aws:sqs:<aws_region>:<account_id>:<sqs_queue.fifo>"
      message_group_id = "fifo-message-group-id-1"
    }
  }
}
```

<br>

Creates an EventBridge Rule that is based on an Event Pattern. There are 2 Standard Queues and 2 FIFO Queues configured as event targets. <br>
**NOTE:** The `message_group_id` parameter is **required** for FIFO Queues.

```hcl
module "mixed_sqs_event_pattern" {
  source        = "../"
  app_name      = "mixed-sqs-targets"
  description   = "Based on an Event Pattern. A combination of Standard and FIFO SQS Queues as event targets."
  event_pattern = <<PATTERN
  {
    "source": ["aws.s3"],
    "detail-type": ["Object Created", "Object Deleted", "Object Storage Class Changed", "Object Tags Added", "Object Tags Deleted"],
    "detail": {
      "bucket": {
        "name": ["s3-bucket-1", "s3-bucket-2"]
      }
    }
  }
  PATTERN

  tags = {
    DevOpsEngineer = "Liche"
  }
  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:<aws_region>:<account_id>:<standard_sqs_queue_1>"
    }
    "queue2" = {
      arn              = "arn:aws:sqs:<aws_region>:<account_id>:<fifo_sqs_queue_1.fifo>"
      message_group_id = "MessageGroupA"
    }
    "queue3" = {
      arn              = "arn:aws:sqs:<aws_region>:<account_id>:<fifo_sqs_queue_2.fifo>"
      message_group_id = "MessageGroupB"
    }
    "queue4" = {
      arn = "arn:aws:sqs:<aws_region>:<account_id>:<standard_sqs_queue_2>"
    }
  }
}
```

<br>

## ECS Usage

### Example 1:

- Creates an EventBridge Rule that is based on a Schedule Expression: `rate(5 minutes)`
- The **Launch Type** parameter and **Capacity Provider Strategy** parameter is **mutually exclusive**.
- There are 3 separate Task Definitions *(that each have their own specific configurations)* configured as event targets.
- An IAM Role is created for EventBridge Rules with ECS targets.

  ```hcl
  module "multiple_ecs_rate" {
    source                  = "../"
    app_name                = "multiple-ecs-targets-1"
    description             = "Based on a Schedule Expression: rate(5 minutes). Multiple ECS Task Definitions as event targets."
    schedule_expression     = "rate(5 minutes)"
    set_provider_strategy   = [true, false, true]
    enable_ecs_managed_tags = [false, true, true]
    enable_execute_command  = [true, true, false]
    launch_types            = [null, "FARGATE", null]
    platform_versions       = ["LATEST", null, "LATEST"]
    propagate_tags          = ["TASK_DEFINITION", null, "TASK_DEFINITION"]
    task_counts             = [3, 2, 1]
    ecs_tags = [
      {
        Dummy = "Test 1"
      },
      {
        Dummy = "Test 1"
      }
    ]

    tags = {
      DevOpsEngineer = "Liche"
    }

    task_definitions = [
      "arn:aws:ecs:<aws_region>:<account_id>:task-definition/<dummy_task_def_1:17>",
      "arn:aws:ecs:<aws_region>:<account_id>:task-definition/<dummy_task_def_2:10>",
      "arn:aws:ecs:<aws_region>:<account_id>:task-definition/<dummy_task_def_3:4>"
    ]

    ecs_clusters = [
      "arn:aws:ecs:<aws_region>:<account_id>:cluster/<dummy-cluster>",
      "arn:aws:ecs:<aws_region>:<account_id>:cluster/<dummy-cluster>",
      "arn:aws:ecs:<aws_region>:<account_id>:cluster/<dummy-cluster>"
    ]

    capacity_provider_strategies = [
      [
        {
          capacity_provider = "FARGATE"
          base              = 1
          weight            = 65
        },
        {
          capacity_provider = "FARGATE_SPOT"
          weight            = 35
        }
      ],
      [],
      [
        {
          capacity_provider = "FARGATE"
          base              = 1
          weight            = 65
        },
        {
          capacity_provider = "FARGATE_SPOT"
          weight            = 35
        }
      ]
    ]

    network_configurations = [
      {
        assign_public_ip = false
        security_groups  = ["<security_group_id>"]
        subnets          = ["<private_subnet_1>", "<private_subnet_2>"]
      },
      {
        assign_public_ip = false
        security_groups  = ["<security_group_id>"]
        subnets          = ["<private_subnet_1>", "<private_subnet_2>"]
      },
      {
        assign_public_ip = false
        security_groups  = ["<security_group_id>"]
        subnets          = ["<private_subnet_1>", "<private_subnet_2>"]
      }
    ]

  }
  ```

<br>

- The index position of each Task Definition is mapped to the index position of all the other parameters specified.
- For example, the Task Definition ARN at index position 1 is:

  `arn:aws:ecs:<aws_region>:<account_id>:task-definition/<dummy_task_def_1:17>`

- The following configurations apply to the aforementioned Task Definition:

  ```hcl
  set_provider_strategy[1]   = false
  enable_ecs_managed_tags[1] = true
  enable_execute_command[1]  = true
  launch_types[1]            = "FARGATE"
  platform_versions[1]       = null
  propagate_tags[1]          = null
  task_counts[1]             = 2

  ecs_tags[1] = {
      Dummy = "Test 1"
    }

  ecs_clusters[1] = "arn:aws:ecs:<aws_region>:<account_id>:cluster/<dummy-cluster>"
  capacity_provider_strategies[1] = []

  network_configurations[1] = {
      assign_public_ip = false
      security_groups  = ["<security_group_id>"]
      subnets          = ["<private_subnet_1>", "<private_subnet_2>"]
    }

  ```

<br>

### Example 2:

- Creates an EventBridge Rule that is based on an Event Pattern.
- There are **NO** Launch Types or Capacity Provider Strategies specified.
- Therefore, Amazon EventBridge will use the default configurations on Amazon ECS (either Launch Type or Capacity Provider Strategy) for each Task Definition.

  ```hcl
  module "multiple_ecs_event_pattern_2" {
    source      = "../"
    app_name    = "multiple-ecs-targets-2"
    description = "Based on an Event Pattern. Multiple ECS Task Definitions as event targets."

    event_pattern = <<PATTERN
    {
      "source": ["aws.s3"],
      "detail-type": ["Object Created", "Object Deleted", "Object Storage Class Changed", "Object Tags Added", "Object Tags Deleted"],
      "detail": {
        "bucket": {
          "name": ["s3-bucket-1", "s3-bucket-2"]
        }
      }
    }
    PATTERN

    set_provider_strategy = [false, false, false]

    ecs_tags = [
      {},
      {},
      {
        Dummy = "Test 1"
      }
    ]

    tags = {
      DevOpsEngineer = "Liche"
    }

    task_definitions = [
      "arn:aws:ecs:<aws_region>:<account_id>:task-definition/<dummy_task_def_1:17>",
      "arn:aws:ecs:<aws_region>:<account_id>:task-definition/<dummy_task_def_1:10>",
      "arn:aws:ecs:<aws_region>:<account_id>:task-definition/<dummy_task_def_1:4>"
    ]

    ecs_clusters = [
      "arn:aws:ecs:<aws_region>:<account_id>:cluster/<dummy_cluster>",
      "arn:aws:ecs:<aws_region>:<account_id>:cluster/<dummy_cluster>",
      "arn:aws:ecs:<aws_region>:<account_id>:cluster/<dummy_cluster>"
    ]

    network_configurations = [
      {
        assign_public_ip = false
        security_groups  = ["<security_group_id>"]
        subnets          = ["<private_subnet_1>", "<private_subnet_2>"]
      },
      {
        assign_public_ip = false
        security_groups  = ["<security_group_id>"]
        subnets          = ["<private_subnet_1>", "<private_subnet_2>"]
      },
      {
        assign_public_ip = false
        security_groups  = ["<security_group_id>"]
        subnets          = ["<private_subnet_1>", "<private_subnet_2>"]
      }
    ]

  }
  ```
