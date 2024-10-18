ejemplos 
```sh
terraform plan \
  -var="aws_region=us-east-1" \
  -var="db_username=root" \
  -var="db_password=1234" \
  -var="vpc_security_group_ids=[\"sg-12345\",\"sg-67890\"]" \
  -var="subnet_ids=[\"subnet-12345\",\"subnet-67890\"]"
```


Explicación de los cambios:
Configuración del proveedor: Se añadió el bloque provider "aws" para especificar la región AWS, lo cual es necesario para la autenticación.

Creación del aws_db_subnet_group: Añadí el recurso aws_db_subnet_group para definir el grupo de subredes, necesario para que RDS pueda conectarse correctamente dentro de la VPC.

Salidas (outputs): Añadí un nuevo output para mostrar la cadena de conexión JDBC, lo que facilitará que puedas conectarte a la base de datos desde aplicaciones que utilicen JDBC.



terraform plan \
  -var="db_username=root" \
  -var="db_password=1234" \
  -var="vpc_security_group_ids=[\"sg-12345\",\"sg-67890\"]" \
  -var="subnet_ids=[\"subnet-12345\",\"subnet-67890\"]"
  
terraform apply \
  -var="db_username=root" \
  -var="db_password=1234" \
  -var="vpc_security_group_ids=[\"sg-12345\",\"sg-67890\"]" \
  -var="subnet_ids=[\"subnet-12345\",\"subnet-67890\"]"