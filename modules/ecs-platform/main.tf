# Creates the ECS cluster, CloudWatch logging, Fargate task definition, and service.

data "aws_region" "current" {}

locals {
  container_environment = [
    for name, value in var.environment_variables : {
      name  = name
      value = value
    }
  ]
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.name_prefix}/portal"
  retention_in_days = var.log_retention_days

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-portal-logs"
  })
}

resource "aws_ecs_cluster" "this" {
  name = "${var.name_prefix}-cluster"

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-cluster"
  })
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.name_prefix}-portal"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = tostring(var.task_cpu)
  memory                   = tostring(var.task_memory)
  execution_role_arn       = aws_iam_role.task_execution.arn
  task_role_arn            = aws_iam_role.task.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      essential = true

      portMappings = [
        {
          name          = "http"
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      environment = local.container_environment

      healthCheck = {
        command = [
          "CMD-SHELL",
          "wget --quiet --output-document=- http://localhost:${var.container_port}${var.health_check_path} > /dev/null || exit 1"
        ]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = var.container_name
        }
      }
    }
  ])

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-portal-task"
  })
}

resource "aws_ecs_service" "this" {
  name                               = "${var.name_prefix}-portal-service"
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this.arn
  desired_count                      = var.desired_count
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  enable_execute_command             = var.enable_execute_command
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  network_configuration {
    subnets          = var.task_subnet_ids
    security_groups  = [aws_security_group.tasks.id]
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [
    aws_iam_role_policy_attachment.task_execution,
    aws_lb_listener.http_forward,
    aws_lb_listener.http_redirect,
    aws_lb_listener.https
  ]

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-portal-service"
  })
}