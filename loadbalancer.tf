# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
resource "aws_lb_target_group" "this" {
  name     = "application-front"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 2

  }
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment
resource "aws_lb_target_group_attachment" "attach-app1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.app-server1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "attach-app2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.app-server2.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "attach-app3" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.app-server3.id
  port             = 80
}
