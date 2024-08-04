output "grafana_server_url" {
  description = "The URL to connect to Grafana Server"
  value       = "http://${module.grafana.public_ip}:3000"
}
