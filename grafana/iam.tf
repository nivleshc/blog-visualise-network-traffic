# create an IAM role for the Grafana EC2 instance.
resource "aws_iam_role" "grafana_role" {
  name               = format("%s-role", var.grafana_server_details["tags"]["Name"])
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# give the Grafana IAM role permissions to read the CloudWatch Logs
resource "aws_iam_role_policy_attachment" "cloudwatch_readonly_attachment" {
  role       = aws_iam_role.grafana_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

# create an IAM instance profile which will be attached to the Grafana EC2 instance
resource "aws_iam_instance_profile" "grafana_profile" {
  name = format("%s-instance-profile", var.grafana_server_details["tags"]["Name"])
  role = aws_iam_role.grafana_role.name
}
