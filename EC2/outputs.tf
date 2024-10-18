output "ssh_command" {
  description = "Comando para conectarse a la instancia via SSH"
  value       = "ssh ubuntu@${aws_instance.app_server.public_ip}"
}
output "instance_password" {
  description = "La contraseña de la instancia EC2"
  value       = aws_instance.app_server.password_data
}
