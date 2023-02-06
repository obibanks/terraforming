#alb
resource "aws_lb" "apache" {
  name               = "altschool"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = aws_subnet.subnets[*].id

  enable_deletion_protection = false

  tags = altschool
}

#alb target group
resource "aws_lb_target_group" "apache" {
  name        = "apache-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  tags = altschool
}

#alb listener
resource "aws_lb_listener" "apache" {
  load_balancer_arn = aws_lb.apache.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache.arn
  }

  tags = altschool
}

#alb target group attachment
resource "aws_lb_target_group_attachment" "apache" {
  target_group_arn = aws_lb_target_group.apache.arn
  target_id        = aws_instance.apache[count.index].id
  port             = 80
}
