terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/router-api.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.13"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = var.assume_role_arn
  }
}

module "task_definition" {
  source                           = "../../../modules/task-definitions/router-api"
  service_name                     = "router-api"
  image_tag                        = var.image_tag
  mesh_name                        = var.mesh_name
  execution_role_arn               = data.aws_iam_role.execution.arn
  mongodb_url                      = var.router_mongodb_url
  service_discovery_namespace_name = local.service_discovery_namespace_name
  govuk_app_domain_external        = var.app_domain
  router_urls                      = local.router_urls
  task_role_arn                    = data.aws_iam_role.task.arn
  sentry_environment               = var.sentry_environment
  assume_role_arn                  = var.assume_role_arn
}
