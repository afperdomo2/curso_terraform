output "vpc_id" {
  value       = module.networking.vpc_id
  description = "ID de la VPC creada"
}

output "subnet_id" {
  value       = module.networking.subnet_id
  description = "ID de la subnet pública creada"
}

output "security_group_id" {
  value       = module.security.security_group_id
  description = "ID del security group web"
}

output "instance_public_ips" {
  value       = module.compute.public_ips
  description = "Direcciones IP públicas de las instancias EC2"
}

output "web_urls" {
  value       = module.compute.web_urls
  description = "URLs HTTP de acceso a las instancias EC2"
}
