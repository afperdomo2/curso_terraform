# -------------------------------------------------------
# Data source: AMI más reciente de Amazon Linux 2023
# -------------------------------------------------------
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

# -------------------------------------------------------
# Instancia EC2
# -------------------------------------------------------
resource "aws_instance" "ec2_instance" {
  count = var.instance_count

  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true

  key_name = var.key_name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
  }

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Servidor Amazon Linux 2023 desplegado por Terraform</h1>" > /var/www/html/index.html
  EOF

  tags = merge(var.common_tags, {
    Name = "${var.name_prefix}-web-${count.index + 1}"
  })
}
