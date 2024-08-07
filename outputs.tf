output "rule_arn" {
  value       = aws_cloudwatch_event_rule.this[0].arn
  description = "The ARN of the EventBridge Rule."
}