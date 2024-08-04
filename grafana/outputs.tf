output "public_ip" {
  description = "The public ip of the grafana server"
  value       = aws_instance.grafana_server.public_ip

  depends_on = [
    aws_instance.grafana_server
  ]
}
