#!/bin/bash

# Descomentar y permitir autenticación por contraseña
sed -i 's/^#PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Reiniciar el servicio SSH para aplicar los cambios
systemctl restart ssh

# Cambiar la contraseña del usuario 'ubuntu'
echo "ubuntu:3141592654" | chpasswd
