output "user_name" {
  value       = aws_iam_user.app_server.name
  description = "Nombre del usuario IAM creado para la aplicación"
}

output "user_arn" {
  value       = aws_iam_user.app_server.arn
  description = "ARN del usuario IAM creado para la aplicación"
}
