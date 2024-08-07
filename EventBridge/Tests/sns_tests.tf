module "one_sns_topic_rate" {
  source              = "../"
  app_name            = "test-1-sns-target"
  description         = "Based on a Schedule Expression: rate(5 minutes). One SNS Topic as an event target."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "sns-test-1"
  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding"
  ]
}

module "one_sns_topic_cron" {
  source              = "../"
  app_name            = "test-2-sns-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). One SNS Topic as an event target."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "sns-test-2"
  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding"
  ]
}

module "one_sns_topic_event_pattern" {
  source        = "../"
  app_name      = "test-3-sns-target"
  description   = "Based on an Event Pattern. One SNS Topic as an event target."
  event_pattern = <<PATTERN
  {
    "source" : ["aws.ecs"],
    "detail-type" : ["ECS Deployment State Change"]
  }
  PATTERN

  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "sns-test-3"
  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding"
  ]
}

module "three_sns_topics_rate" {
  source              = "../"
  app_name            = "test-4-sns-target"
  description         = "Based on a Schedule Expression: rate(5 minutes). Three SNS Topics as event targets."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }

  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding",
    "arn:aws:sns:eu-west-1:865204308355:TokenNotification",
    "arn:aws:sns:eu-west-1:865204308355:TransactionConsentTopic"
  ]
}

module "three_sns_topics_cron" {
  source              = "../"
  app_name            = "test-5-sns-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). Three SNS Topics as event targets."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }

  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding",
    "arn:aws:sns:eu-west-1:865204308355:TokenNotification",
    "arn:aws:sns:eu-west-1:865204308355:TransactionConsentTopic"
  ]
}

module "three_sns_topics_event_pattern" {
  source        = "../"
  app_name      = "test-6-sns-target"
  description   = "Based on an Event Pattern. Three SNS Topics as event targets."
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

  sns_target = [
    "arn:aws:sns:eu-west-1:865204308355:test_forwarding",
    "arn:aws:sns:eu-west-1:865204308355:TokenNotification",
    "arn:aws:sns:eu-west-1:865204308355:TransactionConsentTopic"
  ]
}