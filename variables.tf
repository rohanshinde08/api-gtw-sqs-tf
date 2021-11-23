variable "environment" {
  description = "Env"
  default     = "dev"
}

variable "name" {
  description = "Application Name"
  type        = string
}

locals {
  description = "Aplication Name"
  app_name    = "${var.name}-${var.environment}"
}

variable "region" {
  default = "us-east-1"
}

variable "lambda_name" {
  description = "Name for lambda function"
  default     = "lambda"
}

variable "retention_period" {
  description = "Time (in seconds) that messages will remain in queue before being purged"
  type        = number
  default     = 86400
}

variable "visibility_timeout" {
  description = "Time (in seconds) that consumers have to process a message before it becomes available again"
  type        = number
  default     = 60
}

variable "receive_count" {
  description = "The number of times that a message can be retrieved before being moved to the dead-letter queue"
  type = number
  default = 3
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  type = number
  default = 262144
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed"
  type = number
  default = 0
}