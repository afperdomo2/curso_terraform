locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Organization = var.org_name
    Project      = var.project_name
    Environment  = var.environment
    Owner        = "felipe"
    CreatedBy    = "terraform"
  }
}
