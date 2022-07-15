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
