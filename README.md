# 🌱 Curso Terraform

Bienvenido al curso de Terraform. Este repositorio contiene ejemplos básicos y comandos esenciales para iniciar tu flujo de trabajo con Terraform.

## 🚀 1. Inicio rápido

### 1.1. Prepara tu directorio de trabajo para otros comandos

```sh
terraform init
```

### 1.2. Genera un plan especulativo de ejecución y lo guarda con el nombre dado

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
terraform destroy
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
| **01-intro** | Introducción y primeros pasos. Uso de variables (`variables.tf` y `terraform.tfvars`) |
| **02-outputs** | Salida de valores con `output` y cómo exponer información de tus recursos. |
| **03-almacenamiento** | Creación de un recurso `aws_s3_bucket` y uso de variables locales para simplificar configuraciones. |
| **04-estado-remoto** | Configuración de backend remoto con `s3` para almacenar el `terraform.tfstate` de forma compartida y segura. |

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

## Utilidades

Recurso para crear sufijos o prefijos para colocarle a los nombres de los recursos

```json
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}
```
