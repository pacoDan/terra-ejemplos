provider "aws" {
  region = var.aws_region
}

# Obtener las zonas de disponibilidad
data "aws_availability_zones" "available" {}

# Crear una nueva VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC-example"
  }
}

# Crear un Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "MyInternetGateway-example"
  }
}

# Crear una tabla de rutas
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "MyRouteTable-example"
  }
}

# Asociar la tabla de rutas con las subredes
resource "aws_route_table_association" "this" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.this.id
}

# Crear subredes en la VPC
resource "aws_subnet" "this" {
  count                   = var.subnet_count
  vpc_id                 = aws_vpc.this.id
  cidr_block             = cidrsubnet(var.vpc_cidr_block, 8, count.index) # Cambia el tamaño según sea necesario
  availability_zone      = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "MySubnet-${count.index}"
  }
}

# Crear un grupo de seguridad para la RDS
resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Cambia esto según tus necesidades de seguridad
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyRDSGroup"
  }
}

# Definir el grupo de subredes para la instancia RDS
resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = aws_subnet.this[*].id  # Usamos los subnets creados
  tags = {
    Name = "DB subnet group"
  }
}

# Definir la instancia RDS
resource "aws_db_instance" "this" {
  engine                 = "mysql"
  instance_class         = var.db_instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  publicly_accessible    = true
  skip_final_snapshot    = true
}

# Salidas (outputs)
output "endpoint" {
  value = aws_db_instance.this.endpoint
}

output "username" {
  value = var.db_username
}

output "password" {
  value = var.db_password
}

output "jdbc_connection_string" {
  value = "jdbc:mysql://${aws_db_instance.this.endpoint}/servicio2?user=${var.db_username}&password=${var.db_password}"
}