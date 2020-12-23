terraform {
  backend "s3" {
    bucket  = "govuk-terraform-test"
    key     = "projects/grafana-app-config.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

data "terraform_remote_state" "monitoring" {
  backend = "s3"
  config = {
    bucket   = "govuk-terraform-test"
    key      = "projects/monitoring.tfstate"
    region   = "eu-west-1"
    role_arn = var.assume_role_arn
  }
}

module "grafana-app-config" {
  source = "../../../../modules/monitoring-apps/grafana"
  url    = "https://${data.terraform_remote_state.monitoring.outputs.grafana_fqdn}"
  auth   = "admin:admin" #TODO: fix auth, right now grafana is protected via firewall only and also reads cloudwatch.
}
