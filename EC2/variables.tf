variable "public_key_path" {
  description = "La ruta al archivo de la clave pública SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
