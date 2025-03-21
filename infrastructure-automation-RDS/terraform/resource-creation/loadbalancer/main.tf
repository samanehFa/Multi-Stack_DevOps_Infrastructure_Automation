
resource "aws_lb_target_group" "frontend-lb" {
  name     = "frontend-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "frontend-result" {
  name     = "frontend-result"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "frontend-lb" {
  target_group_arn = aws_lb_target_group.frontend-lb.arn
  target_id        = var.frontend-vote-result
  port            = 80
}

resource "aws_lb_target_group_attachment" "frontend-result" {
  target_group_arn = aws_lb_target_group.frontend-result.arn
  target_id        = var.frontend-vote-result
  port            = 8080
}


resource "aws_lb" "load_balancer" {
  name               = "load-balancer"
  internal           = false  
  load_balancer_type = "application"
  security_groups    = [var.alb-sg]  
  subnets           = [var.subnet_id_public1, var.subnet_id_public2]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-lb.arn
  }
}

resource "aws_lb_listener_rule" "http_listener_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 10
  conditions {
    field  = "path-pattern"
    values = ["/result/*"]
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-result.arn
  }
}