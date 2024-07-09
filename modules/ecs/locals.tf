# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

locals {
  service_map = {
    application = {
      create                        = true
      service_scaling               = true
      service_container_definitions = jsonencode([module.app_container.json_map_object])
      service_task_cpu              = 256
      service_task_memory           = 512
      service_desired_count         = 1
      ecs_load_balancers = [
        {
          target_group_arn = element(module.alb.target_group_arns, 0),
          container_name   = var.app_name
          container_port   = 80
        }
      ]
      docker_volumes = [

      ]
    }
  }
}
