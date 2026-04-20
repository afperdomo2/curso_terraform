output "instance_public_ip" {
  value       = aws_instance.ec2_instance.*.public_ip
  description = "Dirección IP pública de la instancia EC2"
}

output "web_url" {
  value       = "http://${aws_instance.ec2_instance.*.public_ip[0]}"
  description = "URL para acceder al servidor web desplegado en la instancia EC2"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID de la VPC creada"
}

output "subnet_id" {
  value       = aws_subnet.main_subnet.id
  description = "ID de la Subnet creada"
}
