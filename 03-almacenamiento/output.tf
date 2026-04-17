output "bucket_name" {
  value       = aws_s3_bucket.s3-assets.bucket
  description = "Nombre del bucket S3 creado para almacenar los assets de la aplicación"
}

output "bucket_arn" {
  value       = aws_s3_bucket.s3-assets.arn
  description = "ARN del bucket S3 creado para almacenar los assets de la aplicación"
}
