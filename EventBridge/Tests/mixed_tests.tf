module "mixed_test_1" {
  source        = "../"
  app_name      = "mixed-test-1"
  description   = "Based on an Event Pattern. Two SNS Topics, two Lambda Functions and one SQS Queue as event targets."
  event_pattern = <<PATTERN
  {
    "source": ["aws.ec2"],
    "detail-type": ["EC2 Instance State-change Notification"],
    "detail": {
        "state": ["stopping", "shutting-down", "pending"],
        "instance-id": ["i-0a56c9124be94de14", "i-0d98862c3f45fe593", "i-0c2d95537cd302ed8"]
    }
  }
  PATTERN

  tags = {
    DevOpsEngineer = "Liche"
  }

  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding",
    "arn:aws:sns:eu-west-1:865204308355:TokenNotification"
  ]

  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc",
    "arn:aws:lambda:eu-west-1:865204308355:function:TestRabbitMQListener"
  ]

  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:BillingTransactionsJobQueue"
    }
  }

}

module "mixed_test_2" {
  source              = "../"
  app_name            = "mixed-test-2"
  description         = "Based on a Schedule Expression: rate(5 minutes). One SNS Topic, one Lambda Function, two FIFO SQS Queues and one Standard SQS Queue."
  schedule_expression = "rate(5 minutes)"

  tags = {
    DevOpsEngineer = "Liche"
  }

  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding"
  ]

  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc"
  ]

  sqs_target = {
    "queue1" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "MessageGroupA"
    }
    "queue2" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:dev-payouts-payout-update-queue.fifo"
      message_group_id = "MessageGroupB"
    }
    "queue3" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:TransactionVerificationQueue"
    }
  }

}

module "mixed_test_3" {
  source              = "../"
  app_name            = "mixed-test-3"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). One SNS Topic, one Lambda Function, two FIFO SQS Queues and one Standard SQS Queue."
  schedule_expression = "cron(0 20 * * ? *)"

  tags = {
    DevOpsEngineer = "Liche"
  }

  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding"
  ]

  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc"
  ]

  sqs_target = {
    "queue1" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "MessageGroupA"
    }
    "queue2" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:dev-payouts-payout-update-queue.fifo"
      message_group_id = "MessageGroupB"
    }
    "queue3" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:TransactionVerificationQueue"
    }
  }

}

module "mixed_test_4" {
  source              = "../"
  app_name            = "mixed-test-4"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). One Lambda Function, one FIFO SQS Queue and three ECS Task Definitions."
  schedule_expression = "cron(0 20 * * ? *)"

  tags = {
    DevOpsEngineer = "Liche"
  }

  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc"
  ]

  sqs_target = {
    "queue1" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "MessageGroupA"
    }
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

  set_provider_strategy = [false, false, false]

  ecs_tags = [
    {},
    {},
    {
      Dummy = "Test 1"
    }
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