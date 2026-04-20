# -------------------------------------------------------
# Módulo: Networking
# Responsabilidad: VPC, Subnet pública, IGW, Route Table
# -------------------------------------------------------
module "networking" {
  source = "./modules/networking"

  name_prefix       = local.name_prefix
  vpc_cidr          = "10.0.0.0/16"
  subnet_cidr       = "10.0.1.0/24"
  availability_zone = "${var.region}a"
  common_tags       = local.common_tags
}

# -------------------------------------------------------
# Módulo: Security
# Responsabilidad: Security Groups
# -------------------------------------------------------
module "security" {
  source = "./modules/security"

  name_prefix = local.name_prefix
  vpc_id      = module.networking.vpc_id
  common_tags = local.common_tags
}

# -------------------------------------------------------
# Módulo: Compute
# Responsabilidad: AMI lookup + instancias EC2
# -------------------------------------------------------
module "compute" {
  source = "./modules/compute"

  name_prefix        = local.name_prefix
  instance_type      = var.instance_type
  instance_count     = var.instance_count
  subnet_id          = module.networking.subnet_id
  security_group_ids = [module.security.security_group_id]
  key_name           = var.key_name
  common_tags        = local.common_tags
}
