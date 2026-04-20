data "aws_ami" "amazon_linux_2023_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"] # Filtro para la versión estable actual
  }
}

# 1. VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-vpc"
  })
}

# 2. Subnet
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-subnet"
  })
}

# 3. Internet Gateway (Necesario en AWS para que haya internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-igw"
  })
}

# 4. Tabla de Rutas (Para que la subred sea pública)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-public-rt"
  })
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 5. Security Group (Equivalente a Network Security Group)
resource "aws_security_group" "app_sg" {
  name        = "${var.project_name}-${var.environment}-web-sg"
  description = "Security group para acceso HTTP a la instancia EC2"
  vpc_id      = aws_vpc.main.id

  # Regla HTTP (Puerto 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Salida permitida (Azure lo hace por defecto, AWS requiere código)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux_2023_ami.id
  instance_type = "t3.micro"
  count         = 1 # Cantidad de instancias a crear

  # Asociación de red
  subnet_id                   = aws_subnet.main_subnet.id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = true # Para que la instancia tenga IP pública y sea accesible desde internet

  # Disco de Sistema (OS Disk)
  root_block_device {
    volume_type = "gp3"
    volume_size = 8
  }

  key_name = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              # Actualizar paquetes e instalar Apache (httpd)
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Servidor Amazon Linux 2023 desplegado por Terraform</h1>" > /var/www/html/index.html
              EOF



  tags = merge(local.common_tags, {
    Name = "${var.project_name}-${var.environment}-web-${count.index + 1}"
  })
}

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
