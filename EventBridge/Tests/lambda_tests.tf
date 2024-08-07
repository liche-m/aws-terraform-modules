module "one_lambda_rate" {
  source              = "../"
  app_name            = "test-1-lambda-target"
  description         = "Based on a Schedule Expression: rate(5 minutes). One Lambda Function as an event target."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "lambda-test-1"
  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc"
  ]
}

module "one_lambda_cron" {
  source              = "../"
  app_name            = "test-2-lambda-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). One Lambda Function as an event target."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }
  target_id = "lambda-test-2"
  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc"
  ]
}

module "one_lambda_event_pattern" {
  source        = "../"
  app_name      = "test-3-lambda-target"
  description   = "Based on an Event Pattern. One Lambda Function as an event target."
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
  target_id = "lambda-test-3"
  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc"
  ]
}

module "five_lambdas_rate" {
  source              = "../"
  app_name            = "test-4-lambda-target"
  description         = "Based on a Schedule Expression: rate(5 minutes). Five Lambda Functions as event targets."
  schedule_expression = "rate(5 minutes)"
  tags = {
    DevOpsEngineer = "Liche"
  }

  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc",
    "arn:aws:lambda:eu-west-1:865204308355:function:TestRabbitMQListener",
    "arn:aws:lambda:eu-west-1:865204308355:function:bank-apis-wallet",
    "arn:aws:lambda:eu-west-1:865204308355:function:http-retry",
    "arn:aws:lambda:eu-west-1:865204308355:function:dev-kycScreening-reportProcessingConsumer"
  ]
}

module "five_lambdas_cron" {
  source              = "../"
  app_name            = "test-5-lambda-target"
  description         = "Based on a Schedule Expression: cron(0 20 * * ? *). Five Lambda Functions as event targets."
  schedule_expression = "cron(0 20 * * ? *)"
  tags = {
    DevOpsEngineer = "Liche"
  }

  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc",
    "arn:aws:lambda:eu-west-1:865204308355:function:TestRabbitMQListener",
    "arn:aws:lambda:eu-west-1:865204308355:function:bank-apis-wallet",
    "arn:aws:lambda:eu-west-1:865204308355:function:http-retry",
    "arn:aws:lambda:eu-west-1:865204308355:function:dev-kycScreening-reportProcessingConsumer"
  ]
}

module "five_lambdas_event_pattern" {
  source        = "../"
  app_name      = "test-6-lambda-target"
  description   = "Based on an Event Pattern. Five Lambda Functions as event targets."
  event_pattern = <<PATTERN
  {
    "source": ["aws.autoscaling"],
    "detail-type": ["EC2 Instance Launch Successful", "EC2 Instance Launch Unsuccessful"],
    "detail": {
        "AutoScalingGroupName": ["Api-Service-ASG", "MoneyOut-API-Ozow-ASG", "Payment-Flow-Ozow-ASG", "Payment-Service-API-OZOW-ASG"]
    }
  }
  PATTERN
  tags = {
    DevOpsEngineer = "Liche"
  }

  lambda_target = [
    "arn:aws:lambda:eu-west-1:865204308355:function:websocketpoc",
    "arn:aws:lambda:eu-west-1:865204308355:function:TestRabbitMQListener",
    "arn:aws:lambda:eu-west-1:865204308355:function:bank-apis-wallet",
    "arn:aws:lambda:eu-west-1:865204308355:function:http-retry",
    "arn:aws:lambda:eu-west-1:865204308355:function:dev-kycScreening-reportProcessingConsumer"
  ]
}