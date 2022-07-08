output "instance_app-server1_ip_addr" {
  value = aws_instance.app-server1.public_ip
}
output "instance_app-server2_ip_addr" {
  value = aws_instance.app-server2.public_ip
}