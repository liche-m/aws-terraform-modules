#############################
# One Task Definition Tests #
#############################

# Rate: With Capacity Provider Strategy && NO Launch Type
module "one_ecs_rate" {
  source                = "../"
  app_name              = "test-1-ecs-target"
  description           = "Based on a Schedule Expression: rate(5 minutes). One ECS Task Definition as an event target."
  schedule_expression   = "rate(5 minutes)"
  set_provider_strategy = [true]

  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "ecs-test-1"

  task_definitions = [
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/bulk-payment-api-tests:17"
  ]

  ecs_clusters = [
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate"
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
    ]
  ]

  platform_versions = ["LATEST"]

  network_configurations = [
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    }
  ]

}

# Cron: With Launch Type && NO Capacity Provider Strategy
module "one_ecs_cron" {
  source                = "../"
  app_name              = "test-2-ecs-target"
  description           = "Based on a Schedule Expression: cron(0 20 * * ? *). One ECS Task Definition as an event target."
  schedule_expression   = "cron(0 20 * * ? *)"
  set_provider_strategy = [false]

  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "ecs-test-2"

  task_definitions = [
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/bulk-payment-api-tests:17"
  ]

  launch_types = ["FARGATE"]

  ecs_clusters = [
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate"
  ]

  network_configurations = [
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    }
  ]

}

# Event Pattern: NO Launch Type && NO Capacity Provider Strategy
module "one_ecs_event_pattern" {
  source                = "../"
  app_name              = "test-3-ecs-target"
  description           = "Based on an Event Pattern. One ECS Task Definition as an event target."
  set_provider_strategy = [false]

  event_pattern = <<PATTERN
  {
    "source": ["aws.s3"],
    "detail-type": ["Object Created", "Object Deleted", "Object Storage Class Changed", "Object Tags Added", "Object Tags Deleted"],
    "detail": {
      "bucket": {
        "name": ["dev-detect-idle-lambdas-bucket", "dev-absa-archive"]
      }
    }
  }
  PATTERN

  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "ecs-test-3"

  task_definitions = [
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/bulk-payment-api-tests:17"
  ]

  ecs_clusters = [
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate"
  ]

  network_configurations = [
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    }
  ]

}

##################################
# Multiple Task Definition Tests #
##################################

# Rate: With Launch Types && Capacity Provider Strategies.
module "multiple_ecs_rate" {
  source                  = "../"
  app_name                = "multiple-ecs-targets-test-1"
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
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/bulk-payment-api-tests:17",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/merchant-services-ui-tests:2",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/special-projects-tests:2"
  ]

  ecs_clusters = [
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate"
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
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    }
  ]

}

# Cron: Only Capacity Provider Strategies. No Launch Types.
module "multiple_ecs_cron" {
  source                  = "../"
  app_name                = "multiple-ecs-targets-test-2"
  description             = "Based on a Schedule Expression: cron(0 20 * * ? *). Multiple ECS Task Definitions as event targets."
  schedule_expression     = "cron(0 20 * * ? *)"
  set_provider_strategy   = [true, true, true]
  enable_ecs_managed_tags = [true, false, true]
  enable_execute_command  = [false, false, true]
  platform_versions       = [null, "LATEST", null]
  propagate_tags          = [null, "TASK_DEFINITION", null]
  task_counts             = [2, 3, 1]
  ecs_tags = [
    {
      Dummy = "Test 1"
    },
    {},
    {
      Dummy = "Test 1"
    }
  ]

  tags = {
    DevOpsEngineer = "Liche"
  }

  task_definitions = [
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/bulk-payment-api-tests:17",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/merchant-services-ui-tests:2",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/special-projects-tests:2"
  ]

  ecs_clusters = [
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate"
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
    [
      {
        capacity_provider = "FARGATE"
        base              = 1
        weight            = 75
      },
      {
        capacity_provider = "FARGATE_SPOT"
        weight            = 25
      }
    ],
    [
      {
        capacity_provider = "FARGATE"
        base              = 1
        weight            = 55
      },
      {
        capacity_provider = "FARGATE_SPOT"
        weight            = 45
      }
    ]
  ]

  network_configurations = [
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    }
  ]

}

# Event Pattern: Only Launch Types. No Capacity Provider Strategies.
module "multiple_ecs_event_pattern_1" {
  source      = "../"
  app_name    = "multiple-ecs-targets-test-3"
  description = "Based on an Event Pattern. Multiple ECS Task Definitions as event targets."

  event_pattern = <<PATTERN
  {
    "source": ["aws.s3"],
    "detail-type": ["Object Created", "Object Deleted", "Object Storage Class Changed", "Object Tags Added", "Object Tags Deleted"],
    "detail": {
      "bucket": {
        "name": ["dev-detect-idle-lambdas-bucket", "dev-absa-archive"]
      }
    }
  }
  PATTERN

  set_provider_strategy = [false, false, false]
  launch_types          = ["FARGATE", "FARGATE", "FARGATE"]

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
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/bulk-payment-api-tests:17",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/merchant-services-ui-tests:2",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/special-projects-tests:2"
  ]

  ecs_clusters = [
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate"
  ]

  network_configurations = [
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    }
  ]

}

# Event Pattern: No Launch Types. No Capacity Provider Strategies.
module "multiple_ecs_event_pattern_2" {
  source      = "../"
  app_name    = "multiple-ecs-targets-test-4"
  description = "Based on an Event Pattern. Multiple ECS Task Definitions as event targets."

  event_pattern = <<PATTERN
  {
    "source": ["aws.s3"],
    "detail-type": ["Object Created", "Object Deleted", "Object Storage Class Changed", "Object Tags Added", "Object Tags Deleted"],
    "detail": {
      "bucket": {
        "name": ["dev-detect-idle-lambdas-bucket", "dev-absa-archive"]
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
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/bulk-payment-api-tests:17",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/merchant-services-ui-tests:2",
    "arn:aws:ecs:eu-west-1:865204308355:task-definition/special-projects-tests:2"
  ]

  ecs_clusters = [
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate",
    "arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate"
  ]

  network_configurations = [
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    },
    {
      assign_public_ip = false
      security_groups  = ["sg-0276e724083cc837d"]
      subnets          = ["subnet-0cae8640b1c4e24f7", "subnet-0a12a759296e4ae46"]
    }
  ]

}