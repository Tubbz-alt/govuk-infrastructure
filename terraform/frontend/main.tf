provider "aws" {
  version = "~> 2.69"
  region  = "eu-west-1"
}

module "infra-fargate" {
  source                = "../modules/infra-fargate"
  service_name          = "frontend"
  container_definitions = file("../task-definitions/frontend.json")
  desired_count         = 1
}
