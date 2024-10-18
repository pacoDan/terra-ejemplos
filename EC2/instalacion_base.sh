instalacion de recursos necesarios para levantar el wordpress
sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get install -y unzip apache2 mysql-server php libapache2-mod-php php-mysql php-xml php-gd php-curl php-mbstring
# instalacion de docker
# sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y
# sudo apt-get install -y ca-certificates curl gnupg lsb-release
#
# # Crear el directorio para la clave GPG
# sudo install -m 0755 -d /etc/apt/keyrings
#
# # Descargar la clave GPG oficial de Docker
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc >/dev/null
#
# # Otorgar los permisos adecuados para la clave GPG
# sudo chmod a+r /etc/apt/keyrings/docker.asc
#
# # Agregar el repositorio oficial de Docker según la arquitectura y distribución
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
#
# # Actualizar nuevamente los repositorios para incluir Docker
# sudo apt-get update -y
#
# # Instalar Docker
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#
# # Habilitar e iniciar Docker
# sudo systemctl enable docker
# sudo systemctl restart docker
#
# # Verificar la instalación de Docker
# docker --version
