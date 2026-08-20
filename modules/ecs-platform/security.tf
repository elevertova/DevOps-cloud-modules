# Defines separate security boundaries for the public ALB and private ECS tasks.

resource "aws_security_group" "alb" {
  name_prefix = "${var.name_prefix}-alb-"
  description = "Controls inbound traffic to the public application load balancer."
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-alb-sg"
  })
}

resource "aws_security_group" "tasks" {
  name_prefix = "${var.name_prefix}-tasks-"
  description = "Allows application traffic only from the load balancer."
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-tasks-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  for_each = toset(var.alb_ingress_cidrs)

  security_group_id = aws_security_group.alb.id
  description       = "Allow public HTTP traffic."
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = each.value
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  for_each = var.certificate_arn == null ? toset([]) : toset(var.alb_ingress_cidrs)

  security_group_id = aws_security_group.alb.id
  description       = "Allow public HTTPS traffic."
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = each.value
}

resource "aws_vpc_security_group_egress_rule" "alb_to_tasks" {
  security_group_id            = aws_security_group.alb.id
  description                  = "Allow the ALB to send application traffic to ECS tasks."
  ip_protocol                  = "tcp"
  from_port                    = var.container_port
  to_port                      = var.container_port
  referenced_security_group_id = aws_security_group.tasks.id
}

resource "aws_vpc_security_group_ingress_rule" "tasks_from_alb" {
  security_group_id            = aws_security_group.tasks.id
  description                  = "Allow application traffic only from the ALB."
  ip_protocol                  = "tcp"
  from_port                    = var.container_port
  to_port                      = var.container_port
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "tasks_outbound" {
  security_group_id = aws_security_group.tasks.id
  description       = "Allow tasks to reach ECR, CloudWatch, and required external services."
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}