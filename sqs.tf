resource "aws_sqs_queue" "queue" {
  name                       = "apigateway-queue"
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.retention_period
  visibility_timeout_seconds = var.visibility_timeout
  redrive_policy = jsonencode({
    "deadLetterTargetArn" = aws_sqs_queue.deadletter_queue.arn,
    "maxReceiveCount"     = var.receive_count
  })
  receive_wait_time_seconds = 10

  tags = {
    Product = local.app_name
  }
}

resource "aws_sqs_queue" "deadletter_queue" {
  name                       = "queue-DLQ"
  message_retention_seconds  = var.retention_period
  visibility_timeout_seconds = var.visibility_timeout
}

# Trigger lambda on message to SQS
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size       = 1
  event_source_arn = aws_sqs_queue.queue.arn
  enabled          = true
  function_name    = aws_lambda_function.lambda_sqs.arn
}