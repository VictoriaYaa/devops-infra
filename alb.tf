# Create AWS Application Load Balancer
resource "aws_lb" "vic-alb" {
  name  = "vic-alb"
  internal  = false
  load_balancer_type    = "application"
  security_groups   = [aws_security_group.alb-security-group.id]
  subnets   = [for subnet in module.vpc.public_subnets : subnet.id]

  enable_deletion_protection = false

  tags  = {
      Name  = "application load balancer"
  }
}

# Create Target Group
resource "aws_lb_target_group" "alb-target-group" {
  name        = "my-web-server"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
}

# Create a Listener on Port 80 with Redirect Action
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.vic-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Create a Listener on Port 443 with Forward Action
resource "aws_lb_listener" "alb-listener-ssl-certificate" {
  load_balancer_arn = aws_lb.vic-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn

  }
}

