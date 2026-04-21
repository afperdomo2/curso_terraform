import {
  to = aws_s3_bucket.my_remote_bucket
  id = "felipe-pruebas-s3-bucket" # No uses el ARN, solo el nombre
}

resource "aws_s3_bucket" "my_remote_bucket" {
  # Por ahora no pongas nada aquí, Terraform lo generará por ti

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user" "new_iam_user" {
  name = "terraform-test-user"
}

output "bucket_name" {
  value = aws_s3_bucket.my_remote_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.my_remote_bucket.arn
}

output "iam_user_name" {
  value = aws_iam_user.new_iam_user.name
}

output "iam_user_arn" {
  value = aws_iam_user.new_iam_user.arn
}
