module "one_sqs_rate" {
  source              = "../"
  app_name            = "test-1-sqs-target"
  description         = "Based on a Schedule Expression: rate(5 minutes). One SQS Queue as an event target."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "sqs-test-1"
  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:BillingTransactionsJobQueue"
    }
  }
}

module "one_fifo_sqs_rate" {
  source              = "../"
  app_name            = "test-1-fifo-sqs-target"
  description         = "Based on a Schedule Expression: rate(5 minutes). One FIFO SQS Queue as an event target."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "fifo-sqs-test-1"
  sqs_target = {
    "queue1" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "fifo-message-group-id-1"
    }
  }
}

module "one_sqs_cron" {
  source              = "../"
  app_name            = "test-2-sqs-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). One SNS Topic as an event target."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "sqs-test-2"
  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:BillingTransactionsJobQueue"
    }
  }
}

module "one_fifo_sqs_cron" {
  source              = "../"
  app_name            = "test-2-fifo-sqs-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). One SNS Topic as an event target."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "fifo-sqs-test-2"
  sqs_target = {
    "queue1" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "fifo-message-group-id-1"
    }
  }
}

module "one_sqs_event_pattern" {
  source        = "../"
  app_name      = "test-3-sqs-target"
  description   = "Based on an Event Pattern. One SQS Queue as an event target."
  event_pattern = <<PATTERN
  {
    "source": ["aws.ecs"],
    "detail-type": ["ECS Deployment State Change"],
    "detail": {
        "clusterArn": ["arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate", "arn:aws:ecs:eu-west-1:865204308355:cluster/AWSBatch-bulk-payouts-environment-bc1bc795-588e-3c9a-83c1-a7175e30478f"]
    }
  }
  PATTERN

  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "sqs-test-3"
  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:BillingTransactionsJobQueue"
    }
  }
}

module "one_fifo_sqs_event_pattern" {
  source        = "../"
  app_name      = "test-2-fifo-sqs-target"
  description   = "Based on an Event Pattern. One FIFO SQS Queue as an event target."
  event_pattern = <<PATTERN
  {
    "source": ["aws.ecs"],
    "detail-type": ["ECS Deployment State Change"],
    "detail": {
        "clusterArn": ["arn:aws:ecs:eu-west-1:865204308355:cluster/ozow-ecs-fargate", "arn:aws:ecs:eu-west-1:865204308355:cluster/AWSBatch-bulk-payouts-environment-bc1bc795-588e-3c9a-83c1-a7175e30478f"]
    }
  }
  PATTERN

  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "fifo-sqs-test-3"
  sqs_target = {
    "queue1" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "fifo-message-group-id-1"
    }
  }
}

module "mixed_sqs_rate" {
  source              = "../"
  app_name            = "test-1-mixed-sqs-target"
  description         = "Based on a Schedule Expression: rate(5 minutes). A combination of Standard and FIFO SQS Queues as event targets."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:BillingTransactionsJobQueue"
    }
    "queue2" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "MessageGroupA"
    }
    "queue3" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:dev-payouts-payout-update-queue.fifo"
      message_group_id = "MessageGroupB"
    }
    "queue4" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:TransactionVerificationQueue"
    }
  }
}

module "mixed_sqs_cron" {
  source              = "../"
  app_name            = "test-2-mixed-sqs-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). A combination of Standard and FIFO SQS Queues as event targets."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:BillingTransactionsJobQueue"
    }
    "queue2" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "MessageGroupA"
    }
    "queue3" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:dev-payouts-payout-update-queue.fifo"
      message_group_id = "MessageGroupB"
    }
    "queue4" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:TransactionVerificationQueue"
    }
  }
}

module "mixed_sqs_event_pattern" {
  source        = "../"
  app_name      = "test-3-mixed-sqs-target"
  description   = "Based on an Event Pattern. A combination of Standard and FIFO SQS Queues as event targets."
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
  sqs_target = {
    "queue1" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:BillingTransactionsJobQueue"
    }
    "queue2" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:BulkRequestPaymentProcessorQueue.fifo"
      message_group_id = "MessageGroupA"
    }
    "queue3" = {
      arn              = "arn:aws:sqs:eu-west-1:865204308355:dev-payouts-payout-update-queue.fifo"
      message_group_id = "MessageGroupB"
    }
    "queue4" = {
      arn = "arn:aws:sqs:eu-west-1:865204308355:TransactionVerificationQueue"
    }
  }
}