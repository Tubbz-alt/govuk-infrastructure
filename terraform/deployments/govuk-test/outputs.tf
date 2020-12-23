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

output "service_discovery_private_dns_namespace_id" {
  value       = module.govuk.service_discovery_private_dns_namespace_id
  description = "ID of the private DNS namespace for service dicovery"
}

output "service_discovery_private_dns_namespace_name" {
  value       = module.govuk.service_discovery_private_dns_namespace_name
  description = "Name of the private DNS namespace for service dicovery"
}

output "log_group" {
  value = "govuk"
}

output "mesh_name" {
  value = var.mesh_name
}
