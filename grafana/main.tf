# create the Grafana server
resource "aws_instance" "grafana_server" {
  ami                    = var.grafana_server_details["ami_id"]
  instance_type          = var.grafana_server_details["instance_type"]
  key_name               = var.grafana_server_details["ec2_key_name"]
  subnet_id              = var.grafana_server_details["subnet_id"]
  vpc_security_group_ids = [aws_security_group.grafana_sg.id]

  user_data = templatefile("${path.module}/scripts/user-data.tpl.sh", {
    admin_username = var.grafana_server_details["admin_username"],
    admin_password = var.grafana_server_details["admin_password"]
  })

  iam_instance_profile = aws_iam_instance_profile.grafana_profile.name

  tags = var.grafana_server_details["tags"]
}
