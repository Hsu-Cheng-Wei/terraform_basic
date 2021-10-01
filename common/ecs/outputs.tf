output "task_definition" {
  value =  {
        family = "${module.core.prefix}-task-definition"
        requires_compatibilities = ["FARGATE"]
        cpu                      = "1024"
        memory                   = "2048"
        network_mode = "awsvpc"
        container_definitions = jsonencode([
          {
            "name": "hello-world",
            "image": "657982184642.dkr.ecr.ap-northeast-1.amazonaws.com/pumpking-hub:latest",      
            "memory": 512,
            "cpu":    256,
            "essential": true,
            "portMappings": [
                {
                  "containerPort": 80,
                  "hostPort":      80
                }
            ]
          }
      ])
  }  
}