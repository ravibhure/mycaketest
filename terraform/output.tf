# OUTPUT
output "wordpress_url" {
  value = "http://${aws_instance.webserver.public_ip}:80"
}
output "grafana_url" {
  value = "http://${aws_instance.monitoring.public_ip}:8090"
}
