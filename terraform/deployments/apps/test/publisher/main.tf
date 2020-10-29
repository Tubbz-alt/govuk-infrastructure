terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/publisher.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.69"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "task_definition" {
  source                           = "../../../../modules/task-definitions/publisher"
  govuk_app_domain_external        = local.govuk_app_domain_external
  govuk_website_root               = local.govuk_website_root
  image_tag                        = var.image_tag
  mesh_name                        = local.mesh_name
  service_discovery_namespace_name = local.service_discovery_namespace_name
  statsd_host                      = local.statsd_host
  execution_role_arn               = data.aws_iam_role.execution.arn
  task_role_arn                    = data.aws_iam_role.task.arn
  redis_host                       = local.redis_host
  redis_port                       = local.redis_port
  asset_host                       = local.asset_host
  sentry_environment               = local.sentry_environment
}