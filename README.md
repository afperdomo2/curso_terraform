# 🌱 Curso Terraform

Bienvenido al curso de Terraform. Este repositorio contiene ejemplos básicos y comandos esenciales para iniciar tu flujo de trabajo con Terraform.

## 🚀 1. Inicio rápido

### 1.1. Prepara tu directorio de trabajo para otros comandos

```sh
terraform init
```

```sh
# Analiza tus archivos en busca de errores de sintaxis y lógica interna (requiere init)
terraform validate
```

### 1.2. Genera un plan especulativo de ejecución y lo guarda con el nombre dado

Realiza una comparación real del código contra la nube. Ejemplo: Si colocamos una región de AWS que no existe, en este punto se genera el error, al hacer el plan.

```sh
# Genera un plan especulativo de ejecución y lo guarda con el nombre dado
terraform plan -out plan.out

# 1. Setear una variable al construir el plan
terraform plan -out plan.out -var="project_name=curso_terraform"

# 2. Setear las variables desde un archivo, aunque por defecto Terraform ya las toma de terraform.tfvars
terraform plan -out plan.out -var-file="terraform.tfvars"

# 3. Setear las configuraciones de 'backend', como por ejemplo el 'bucket' u otras
terraform init -backend-config="region=us-east-1" -backend-config="bucket=apps-afperdomo-backup-bucket"
```

### 1.3. Crea o actualiza la infraestructura del plan guardado

```sh
terraform apply "plan.out"
```

### 1.4. Eliminar la infraestructura creada

```sh
# Destruir todos los recursos craedos
terraform destroy

# Destruir solo un recurso
terraform destroy -target=aws_instance.ec2_instance
```

### Otros comandos

```sh
# Formatea el código con el estándar de HashiCorp. Estética y alineación de texto
terraform fmt -recursive
```

## 📌 2. Comandos principales de Terraform

- `init`      : Prepara tu directorio de trabajo para otros comandos.
- `validate`  : Verifica si la configuración es válida.
- `plan`      : Muestra los cambios que se aplicarán.
- `apply`     : Crea o actualiza la infraestructura.
- `destroy`   : Elimina la infraestructura creada.

## 🧰 3. Otros comandos útiles

- `console`      : Prueba expresiones de Terraform en una consola interactiva.
- `fmt`          : Formatea tu configuración en el estilo estándar.
- `force-unlock` : Libera un bloqueo atascado en el workspace actual.
- `get`          : Instala o actualiza módulos remotos de Terraform.
- `graph`        : Genera un gráfico Graphviz de los pasos de una operación.
- `import`       : Asocia infraestructura existente con un recurso de Terraform.
- `login`        : Obtiene y guarda credenciales para un host remoto.
- `logout`       : Elimina credenciales locales guardadas para un host remoto.
- `metadata`     : Comandos relacionados con metadatos.
- `modules`      : Muestra todos los módulos declarados en el directorio.
- `output`       : Muestra los valores de salida del módulo raíz.
- `providers`    : Muestra los proveedores requeridos por esta configuración.
- `refresh`      : Actualiza el estado para que coincida con los sistemas remotos.
- `show`         : Muestra el estado actual o un plan guardado.
- `state`        : Administración avanzada del estado.
- `taint`        : Marca un recurso como no funcional.
- `untaint`      : Elimina el estado "tainted" de un recurso.
- `version`      : Muestra la versión actual de Terraform.
- `workspace`    : Administración de workspaces.

## ✅ 4. Recomendación

Ejecuta `terraform init` antes de usar `plan`, `apply` o `destroy` para asegurarte de que el directorio de trabajo esté correctamente configurado.

## 🎓 5. Clases del curso

| Clase | Descripción |
| --- | --- |
| **01-intro** | Creación de un usuario IAM básico con variables en `variables.tf` y valores en `terraform.tfvars`. |
| **02-outputs** | Mismo recurso IAM que en `01` y exposición de sus datos con salidas `output`. |
| **03-almacenamiento** | Creación de un bucket S3 (`aws_s3_bucket`) y uso de `local` para etiquetas comunes. |
| **04-estado-remoto** | Configuración de backend remoto `s3` para almacenar el `terraform.tfstate` compartido y cifrado. |
| **05-data** | Uso de un `data` source `aws_iam_group` para leer un grupo IAM existente en AWS, creación de usuario IAM y membership en el grupo. |

## 📦 6. Variables

En este curso se usan dos archivos principales para gestionar variables:

- `variables.tf`: define las variables que Terraform espera recibir.
- `terraform.tfvars`: contiene valores concretos que se aplican automáticamente cuando se ejecuta `terraform plan` o `terraform apply`.

### 📄 6.1. Uso de `variables.tf`

Este archivo debe contener la definición de cada variable con su tipo y descripción.

Ejemplo:

```hcl
variable "project_name" {
  type        = string
  default     = "curso_terraform"
  description = "Nombre del proyecto usado en recursos y etiquetas"
}
```

### 📝 6.2. Uso de `terraform.tfvars`

Este archivo define los valores que quieres usar en tu entorno. No se recomienda subirlo a un repositorio si contiene datos sensibles.

Ejemplo:

```hcl
project_name  = "curso_terraform"
app_terraform = "app_terraform"
created_by    = "terraform"
aws_region    = "us-east-1"
```

### 🚀 6.3. Formas de pasar variables

- Con `terraform.tfvars` o archivos con extensión `.auto.tfvars`
- Con la opción `-var`:

  ```sh
  terraform plan -var="project_name=curso_terraform"
  ```

- Con variables de entorno usando el prefijo `TF_VAR_`:

  ```sh
  export TF_VAR_project_name=curso_terraform
  ```

### 💡 6.4. Recomendaciones

- Usa `description` en cada variable.
- Si no hay un valor por defecto, exige que el usuario lo proporcione.
- No guardes valores sensibles en archivos `.tfvars` sin control de acceso.

## 🗄️ 7. Storage de Terraform

Terraform guarda el estado de la infraestructura en un archivo llamado `terraform.tfstate`. Este archivo contiene la información actual de los recursos creados y es fundamental para que Terraform pueda calcular cambios futuros.

En la clase `04-estado-remoto` se muestra cómo mover este estado a un backend remoto usando `s3`, con parámetros como `bucket`, `key`, `region`, `encrypt` y `use_lockfile`.

### 🔹 Storage local

Por defecto, este curso utiliza el storage local, es decir, el archivo `terraform.tfstate` se crea en el directorio del proyecto. Esto funciona bien para ejemplos pequeños, pero no es ideal cuando varias personas o equipos trabajan sobre la misma infraestructura.

### 🔹 Remote backend

Para proyectos colaborativos, se recomienda usar un backend remoto. Algunos ejemplos comunes son:

- `S3` + `DynamoDB` para bloqueo de estado en AWS.
- `Terraform Cloud` o `Terraform Enterprise`.
- `Azure Storage Account`.
- `Google Cloud Storage`.

El backend remoto asegura que:

- el estado se comparte entre el equipo,
- el estado no se pierde accidentalmente,
- se evita la edición concurrente con bloqueo de estado.

### 🔹 Buenas prácticas

- No subas `terraform.tfstate` al repositorio.
- Usa un backend remoto cuando trabajes en equipo.
- Protege las credenciales usadas para acceder al backend.

## 🔧 Remote state y backend

Cuando se usa un backend remoto, Terraform deja de guardar el estado en el directorio local y lo almacena en un servicio compartido. En la clase `04-estado-remoto` se implementa un backend `s3` con un archivo de configuración de backend para definir:

- `bucket` : nombre del bucket S3 que guarda el estado.
- `key` : ruta y nombre del archivo de estado dentro del bucket.
- `region` : región donde se ubica el bucket.
- `encrypt` : habilita el cifrado del estado en reposo.
- `use_lockfile` : permite bloqueo para evitar cambios concurrentes.

### 📁 Archivo `backend.tf`

El backend puede definirse en un archivo como `backend.tf` o directamente en `main.tf` dentro del bloque `terraform`. Un ejemplo típico es:

```hcl
terraform {
  backend "s3" {
    bucket       = "mi-bucket-terraform"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

Al usar un archivo `backend.tf`, el contenido se mantiene separado de los recursos y se hace más fácil cambiar o reconfigurar el backend.

### 🚀 `terraform init` con `-backend-config`

A veces no quieres dejar valores fijos en el archivo de backend. En ese caso puedes pasar valores al inicializar el directorio con `terraform init`:

```sh
terraform init \
  -backend-config="bucket=apps-afperdomo-backup-bucket" \
  -backend-config="region=us-east-1" \
  -backend-config="key=terraform.tfstate"
```

También puedes usar un archivo separado de backend config, por ejemplo `backend.config`:

```hcl
bucket = "apps-afperdomo-backup-bucket"
region = "us-east-1"
key    = "terraform.tfstate"
```

Y luego inicializar con:

```sh
terraform init -backend-config=backend.config
```

Esto es especialmente útil cuando quieres mantener diferentes entornos (`dev`, `prod`) con configuraciones distintas sin modificar los archivos `.tf`.

## 🔎 Comparativa: `data` vs `import`

Terraform ofrece dos formas distintas de trabajar con recursos existentes:

- `data`: lee información de recursos que ya existen en la nube sin adoptar su gestión completa.
- `import`: trae un recurso existente al estado de Terraform para que luego puedas gestionarlo como un recurso declarado.

### ¿Cuándo usar cada uno?

- Usa `data` cuando necesites consultar atributos de un recurso existente y no quieras que Terraform lo cree o destruya.
- Usa `import` cuando quieras que Terraform comience a gestionar ese recurso existente como parte de tu infraestructura declarada.

### Comparativa

| Característica | `data` source | `terraform import` |
| --- | --- | --- |
| Propósito | Leer información de recursos existentes. | Adoptar un recurso existente en el estado de Terraform. |
| Crea recurso | No. Solo consulta datos. | No crea, pero vincula el recurso existente al recurso declarado. |
| Administración futura | El recurso no está gestionado plenamente por Terraform. | El recurso pasa a ser gestionado por Terraform tras la importación. |
| Uso típico | Consultar IDs, ARNs, configuraciones u otros atributos. | Administrar un recurso existente sin recrearlo. |
| Ejemplo en el curso | `05-data` lee un grupo IAM existente con `aws_iam_group`. | `08-import` importa un bucket S3 existente en el estado con `terraform import`. |

### Nota práctica

En `05-data` se muestra cómo usar un `data` source para leer un recurso ya existente en AWS y usar sus valores en la configuración. En `08-import` se muestra cómo traer un recurso existente al estado de Terraform para gestionarlo posteriormente.

## Utilidades

Recurso para crear sufijos o prefijos para colocarle a los nombres de los recursos

```json
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}
```
