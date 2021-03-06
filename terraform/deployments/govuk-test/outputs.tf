output "private_subnets" {
  value = data.terraform_remote_state.infra_networking.outputs.private_subnet_ids
}

output "publisher-web_security_groups" {
  value = module.govuk.publisher_security_groups
}

output "frontend_security_groups" {
  value = module.govuk.frontend_security_groups
}

output "signon_security_groups" {
  value = module.govuk.signon_security_groups
}

output "content-store_security_groups" {
  value = module.govuk.content_store_security_groups
}

output "draft-content-store_security_groups" {
  value = module.govuk.draft_content_store_security_groups
}
