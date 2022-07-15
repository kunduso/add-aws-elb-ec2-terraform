# output "instance_app-server1_public_dns" {
#   value = aws_instance.app-server1.public_dns
# }
# output "instance_app-server2_public_dns" {
#   value = aws_instance.app-server2.public_dns
# }
# output "instance_app-server3_public_dns" {
#   value = aws_instance.app-server3.public_dns
# }
output "load_balancer_dns_name" {
  value = aws_lb.front.dns_name
}