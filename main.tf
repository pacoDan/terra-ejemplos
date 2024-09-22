terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

# Define el recurso de clave SSH
resource "aws_key_pair" "app_key" {
  key_name   = "app_key"
  public_key = file(var.public_key_path)
}
# Crear una nueva VPC
resource "aws_vpc" "new_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "NewTerraformVPC"
  }
}

# Crear una subred dentro de la nueva VPC
resource "aws_subnet" "new_subnet" {
  vpc_id            = aws_vpc.new_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "NewTerraformSubnet"
  }
}

# Crear un gateway de Internet para la VPC
resource "aws_internet_gateway" "new_gateway" {
  vpc_id = aws_vpc.new_vpc.id

  tags = {
    Name = "NewTerraformGateway"
  }
}

# Crear una tabla de enrutamiento y asociarla a la subred
resource "aws_route_table" "new_route_table" {
  vpc_id = aws_vpc.new_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_gateway.id
  }

  tags = {
    Name = "NewTerraformRouteTable"
  }
}

resource "aws_route_table_association" "new_route_table_association" {
  subnet_id      = aws_subnet.new_subnet.id
  route_table_id = aws_route_table.new_route_table.id
}

# Security Group para permitir SSH desde cualquier dirección
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.new_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permitir desde cualquier IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instancia EC2
resource "aws_instance" "app_server" {
  ami           = "ami-085f9c64a9b75eed5"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.app_key.key_name

  subnet_id              = aws_subnet.new_subnet.id          # Asigna la subred
  vpc_security_group_ids = [aws_security_group.allow_ssh.id] # Asigna el Security Group

  associate_public_ip_address = true #asi se asocia una IP pública a la instancia
  # Cargar el archivo .sh como user_data
  user_data = file("${path.module}/setup_password_auth.sh")

  tags = {
    Name = "ServerDeEjemploTerra"
  }
}

# Salida de la IP pública de la instancia
output "instance_public_ip" {
  description = "La dirección IP pública de la instancia EC2"
  value       = aws_instance.app_server.public_ip
}
