terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/publishing-api-web.tfstate"
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
  source                           = "../../../modules/task-definitions/publishing-api"
  govuk_app_domain_external        = var.app_domain
  govuk_app_domain_internal        = var.app_domain_internal
  govuk_website_root               = local.website_root
  image_tag                        = "bilbof_dockerfile-fix" # TODO: Pinned due to content-schemas issue
  mesh_name                        = var.mesh_name
  service_discovery_namespace_name = local.service_discovery_namespace_name
  statsd_host                      = local.statsd_host
  execution_role_arn               = data.aws_iam_role.execution.arn
  task_role_arn                    = data.aws_iam_role.task.arn
  redis_host                       = var.redis_host
  sentry_environment               = var.sentry_environment
  service_name                     = "publishing-api-web"
  assume_role_arn                  = var.assume_role_arn
}
