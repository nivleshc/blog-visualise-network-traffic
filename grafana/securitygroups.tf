# create a security group that will be attached to the Grafana ec2 instance
resource "aws_security_group" "grafana_sg" {
  name        = "${var.grafana_server_details["tags"]["Name"]}-sg"
  description = "Security group for grafana server"
  vpc_id      = var.grafana_server_details["vpc_id"]

  tags = {
    Name = "${var.grafana_server_details["tags"]["Name"]}-sg"
  }
}

# allow traffic to the grafana console
resource "aws_security_group_rule" "allow_connection_to_grafana_console" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = [var.grafana_server_details.my_ip_address]
  security_group_id = aws_security_group.grafana_sg.id
}

# allow ssh traffic to the grafana ec2 instance
resource "aws_security_group_rule" "allow_ssh_connection_to_grafana_server" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.grafana_server_details.my_ip_address]
  security_group_id = aws_security_group.grafana_sg.id
}

# allow all outgoing traffic from the grafana server
resource "aws_security_group_rule" "allow_outgoing_traffic" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.grafana_sg.id
}
