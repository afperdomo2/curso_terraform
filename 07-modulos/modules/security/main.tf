resource "aws_security_group" "app_sg" {
  name        = "${var.name_prefix}-web-sg"
  description = "Security group para acceso HTTP a la instancia EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP desde cualquier origen"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida irrestricta"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-web-sg"
  })
}
