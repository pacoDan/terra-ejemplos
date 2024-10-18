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
```sh
terraform plan \
  -var="db_username=root" \
  -var="db_password=1234" \
  -var="vpc_security_group_ids=[\"sg-12345\",\"sg-67890\"]" \
  -var="subnet_ids=[\"subnet-12345\",\"subnet-67890\"]"
```
```sh
terraform apply \
  -var="db_username=root" \
  -var="db_password=1234" \
  -var="vpc_security_group_ids=[\"sg-12345\",\"sg-67890\"]" \
  -var="subnet_ids=[\"subnet-12345\",\"subnet-67890\"]"
```

sin alcance
```
feat: add simple RDS instance for testing
```

Con un cambio significativo (si consideras que la adición de RDS es un cambio importante):
```
feat(rds)!: add simple RDS instance for testing connectivity
```

Si hay un cambio que afecta a la API:
```
feat(api): add simple RDS instance for testing connectivity
```

Si en el futuro haces cambios que rompen la compatibilidad, puedes usar el símbolo ! para indicar que hay un cambio significativo.