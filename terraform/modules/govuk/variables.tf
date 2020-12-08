variable "vpc_id" {
  type = string
}

variable "mesh_domain" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "mesh_name" {
  type = string
}

variable "private_subnets" {
  description = "Subnet IDs to use for non-Internet-facing resources."
  type        = list
}

variable "public_subnets" {
  description = "Subnet IDs to use for Internet-facing resources."
  type        = list
}

variable "public_lb_domain_name" {
  description = "Domain in which to create DNS records for Internet-facing load balancers. For example, staging.govuk.digital"
  type        = string
}

variable "public_hosted_zone_id" {
  description = "Hosted Zone ID to add DNS records to for Internet-facing load balancers."
  type        = string
}

variable "govuk_management_access_sg_id" {
  description = "ID of security group (from the govuk-aws repo) for access from jumpboxes etc. This SG is added to all ECS instances."
  type        = string
}

variable "postgresql_security_group_id" {
  description = "ID of security group (from the govuk-aws repo) for the shared Postgres RDS."
  type        = string
}

variable "documentdb_security_group_id" {
  description = "ID of security group (from the govuk-aws repo) for the shared DocumentDB."
  type        = string
}

variable "mongodb_security_group_id" {
  description = "ID of security group (from the govuk-aws repo) for the shared MongoDB."
  type        = string
}

variable "mysql_security_group_id" {
  description = "ID of security group (from the govuk-aws repo) for the shared MySQL RDS."
  type        = string
}

variable "routerdb_security_group_id" {
  description = "ID of security group (from the govuk-aws repo) for the Router MongoDB."
  type        = string
}

variable "frontend_desired_count" {
  description = "Desired count of Frontend Application instances"
  type        = number
}

variable "draft_frontend_desired_count" {
  description = "Desired count of Draft-Frontend Application instances"
  type        = number
}

variable "content_store_desired_count" {
  description = "Desired count of Content-Store Application instances"
  type        = number
}

variable "draft_content_store_desired_count" {
  description = "Desired count of Draft-Content-Store Application instances"
  type        = number
}

variable "publisher_desired_count" {
  description = "Desired count of Publisher Application instances"
  type        = number
}

variable "publishing_api_desired_count" {
  description = "Desired count of Publishing-API Application instances"
  type        = number
}

variable "router_desired_count" {
  description = "Desired count of Router Application instances"
  type        = number
}

variable "draft_router_desired_count" {
  description = "Desired count of Draft-Router Application instances"
  type        = number
}

variable "router_api_desired_count" {
  description = "Desired count of Router-API Application instances"
  type        = number
}

variable "draft_router_api_desired_count" {
  description = "Desired count of Draft-Router-API Application instances"
  type        = number
}

variable "static_desired_count" {
  description = "Desired count of Static Application instances"
  type        = number
}

variable "draft_static_desired_count" {
  description = "Desired count of Draft-Static Application instances"
  type        = number
}

variable "signon_desired_count" {
  description = "Desired count of Signon Application instances"
  type        = number
}

variable "office_cidrs_list" {
  description = "List of GDS office CIDRs"
  type        = list
  default     = ["213.86.153.212/32", "213.86.153.213/32", "213.86.153.214/32", "213.86.153.235/32", "213.86.153.236/32", "213.86.153.237/32", "85.133.67.244/32"]
}

variable "internal_domain_name" {
  description = "Domain in which to create DNS records for private resources. For example, test.govuk-internal.digital"
  type        = string
}

variable "redis_subnets" {
  description = "Subnet IDs to use for Redis cluster"
  type        = list
}
