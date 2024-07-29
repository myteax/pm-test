provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "existing" {
  id = "vpc-0753a5fc9499126f9"
}



resource "aws_ecs_task_definition" "task_definition" {
  family                = "pm1"
  network_mode          = "awsvpc"
  memory = "3072"
  cpu = "1024"
  requires_compatibilities = ["FARGATE", "EC2"]



  execution_role_arn = "arn:aws:iam::716591628268:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name: "mypm",
      image: "716591628268.dkr.ecr.us-east-1.amazonaws.com/mypm:latest",
      cpu: 0,
      essential: true,
      portMappings: [
        {
          "name": "mypm_p_1",
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp",
          "appProtocol": "http"
        },
        {
          "name": "mypm_p_2",
          "containerPort": 8080,
          "hostPort": 8080,
          "protocol": "tcp",
          "appProtocol": "http"
        }
      ],

    }
  ])

}

resource "aws_ecs_cluster" "cluster" {
  name = "jackSparrow"
}

resource "aws_ecs_service" "service" {
  name            = "mypmmservice"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = ["subnet-01334426cc6dcf6dd"]
    security_groups = ["sg-00d2373afe15b3d42"]
    assign_public_ip = true

  }

  desired_count = 2

}
