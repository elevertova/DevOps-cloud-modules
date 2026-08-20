# Defines IAM roles that ECS uses to start and run Fargate tasks.

data "aws_iam_policy_document" "ecs_tasks_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "task_execution" {
  name               = substr("${var.name_prefix}-ecs-execution-role", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-execution-role"
  })
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = aws_iam_role.task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "task" {
  name               = substr("${var.name_prefix}-ecs-task-role", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role.json

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-ecs-task-role"
  })
}