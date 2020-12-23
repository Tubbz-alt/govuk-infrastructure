terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/grafana.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = var.assume_role_arn
  }
}

data "aws_region" "current" {}

# TODO pass this ARN in from the govuk deployment (via terraform remote state) instead of using a data source
data "aws_iam_role" "execution" {
  name = "fargate_execution_role"
}

# TODO pass this ARN in from the govuk deployment (via terraform remote state) instead of using a data source
data "aws_iam_role" "task" {
  name = "grafana_task_role"
}

data "terraform_remote_state" "govuk" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket   = "govuk-terraform-test"
    key      = "projects/govuk.tfstate"
    region   = data.aws_region.current.name
    role_arn = var.assume_role_arn
  }
}

locals {
  log_group = data.terraform_remote_state.govuk.outputs.log_group
  mesh_name = data.terraform_remote_state.govuk.outputs.mesh_name
}

module "container_definition" {
  source                = "../../../modules/app-container-definition"
  name                  = "grafana"
  image                 = "grafana/grafana:${var.image_tag}"
  log_group             = local.log_group
  aws_region            = data.aws_region.current.name
  ports                 = [3000]
  depends_on_containers = { envoy : "START" }
}

module "envoy_configuration" {
  source = "../../../modules/envoy-configuration"

  mesh_name    = local.mesh_name
  service_name = "grafana"
  log_group    = local.log_group
  aws_region   = data.aws_region.current.name
  port         = "3000"
}

resource "aws_ecs_task_definition" "grafana" {
  family                   = "grafana"
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    module.container_definition.value,
    module.envoy_configuration.container_definition,
  ])

  network_mode       = "awsvpc"
  cpu                = 512
  memory             = 1024
  task_role_arn      = data.aws_iam_role.task.arn
  execution_role_arn = data.aws_iam_role.execution.arn
}
