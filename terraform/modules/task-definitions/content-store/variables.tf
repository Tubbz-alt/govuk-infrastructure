variable "govuk_app_domain_external" {
  type = string
}

variable "govuk_website_root" {
  type = string
}

variable "router_api_hostname_prefix" {
  type        = string
  default     = ""
  description = "Leave unset, or use 'draft-' to send requests to the draft router-api."
}

variable "image_tag" {
  description = "Container Image Tag"
  type        = string
}

variable "mesh_name" {
  type = string
}

variable "mongodb_url" {
  type = string
}

variable "service_discovery_namespace_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "statsd_host" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "sentry_environment" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "assume_role_arn" {
  type        = string
  description = "(optional) AWS IAM role to assume. Uses the role from the environment by default."
  default     = null
}
