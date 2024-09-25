#!/bin/bash

# Variables
WORDPRESS_URL="https://es-ar.wordpress.org/latest-es_AR.zip"
WORDPRESS_ZIP="latest-es_AR.zip"
WORDPRESS_DIR="wordpress"
INSTALL_DIR="/var/www/html"  # Cambia esto si tu directorio web es diferente

# Verificar si el paquete unzip está instalado
if ! command -v unzip &> /dev/null; then
    echo "Instalando unzip..."
    sudo apt-get update
    sudo apt-get install -y unzip
fi

# Descargar WordPress
echo "Descargando WordPress..."
wget $WORDPRESS_URL -O $WORDPRESS_ZIP

# Descomprimir WordPress
echo "Descomprimiendo WordPress..."
unzip $WORDPRESS_ZIP

# Crear el directorio de instalación si no existe
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creando el directorio de instalación en $INSTALL_DIR"
    sudo mkdir -p $INSTALL_DIR
fi

# Mover WordPress al directorio de instalación
echo "Moviendo archivos de WordPress a $INSTALL_DIR"
sudo mv $WORDPRESS_DIR/* $INSTALL_DIR/

# Cambiar permisos
echo "Ajustando permisos..."
sudo chown -R www-data:www-data $INSTALL_DIR
sudo chmod -R 755 $INSTALL_DIR

# Copiar archivo wp-config-sample.php como wp-config.php
echo "Configurando wp-config.php..."
sudo cp $INSTALL_DIR/wp-config-sample.php $INSTALL_DIR/wp-config.php

# Variables de la base de datos
DB_NAME="nombredb"
DB_USER="usuariodb"
DB_PASSWORD="contradb"
DB_HOST="localhost"  # Cambia esto si usas un host diferente

# Editar el archivo wp-config.php
sudo sed -i "s/database_name_here/$DB_NAME/" $INSTALL_DIR/wp-config.php
sudo sed -i "s/username_here/$DB_USER/" $INSTALL_DIR/wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/" $INSTALL_DIR/wp-config.php
sudo sed -i "s/localhost/$DB_HOST/" $INSTALL_DIR/wp-config.php

echo "WordPress instalado exitosamente en $INSTALL_DIR."
echo "Puedes continuar configurando WordPress accediendo a tu sitio web."

