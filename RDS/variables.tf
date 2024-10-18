variable "aws_region" {
  type    = string
  default = "us-east-1"  # Cambia esto según tu preferencia
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"  # Cambia esto según tus necesidades
}

variable "subnet_count" {
  type    = number
  default = 2  # Número de subredes a crear
}

variable "db_name" {
  type    = string
  default = "servicio2"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "db_subnet_group_name" {
  type    = string
  default = "my-db-subnet-group"
}