output "instance_app-server_public_dns" {
  value = "http://${aws_instance.app-server.*.public_dns}"
}
output "load_balancer_dns_name" {
  value = "http://${aws_lb.front.dns_name}"
}