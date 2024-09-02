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

# Security Group para permitir SSH desde cualquier dirección
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-05947ffd6ee8a671f" # Asegúrate de tener el VPC correcto si no usas el default

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

  vpc_security_group_ids = [aws_security_group.allow_ssh.id] # Asigna el Security Group

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# Salida de la IP pública de la instancia
output "instance_public_ip" {
  description = "La dirección IP pública de la instancia EC2"
  value       = aws_instance.app_server.public_ip
}
