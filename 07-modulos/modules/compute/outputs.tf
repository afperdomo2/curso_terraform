output "instance_ids" {
  value       = aws_instance.ec2_instance[*].id
  description = "IDs de las instancias EC2 creadas"
}

output "public_ips" {
  value       = aws_instance.ec2_instance[*].public_ip
  description = "Direcciones IP públicas de las instancias EC2"
}

output "web_urls" {
  value       = [for ip in aws_instance.ec2_instance[*].public_ip : "http://${ip}"]
  description = "URLs HTTP de las instancias EC2"
}
