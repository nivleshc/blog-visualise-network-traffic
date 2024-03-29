# enable vpc flow logs
resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.vpc_flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn
  traffic_type    = var.vpc["vpc_flow_logs"]["traffic_to_capture"]
  vpc_id          = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", "vpc-flow-logs", var.vpc["vpc_flow_logs"]["traffic_to_capture"])
  }
}
