resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = var.vpc["vpc_flow_logs"]["cloudwatch_log_group_name"]
  retention_in_days = var.vpc["vpc_flow_logs"]["cloudwatch_log_group_retention_in_days"]
  skip_destroy      = false # force delete the log group when destroying the VPC
}
