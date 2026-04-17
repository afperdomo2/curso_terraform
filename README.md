# 🌱 Curso Terraform

Bienvenido al curso de Terraform. Este repositorio contiene ejemplos básicos y comandos esenciales para iniciar tu flujo de trabajo con Terraform.

## 🚀 1. Inicio rápido

```sh
# 1. Prepara tu directorio de trabajo para otros comandos
terraform init

# 2. Genera un plan especulativo de ejecución y lo guarda con el nombre dado
terraform plan -out plan.out

# Setear una variable al construir el plan
terraform plan -out plan.out -var="project_name=curso_terraform"

# Setear las variables desde un archivo, aunque por defecto Terraform ya las toma de terraform.tfvars
terraform plan -out plan.out -var-file="terraform.tfvars"

# 3. Crea o actualiza la infraestructura del plan guardado
terraform apply "plan.out"

# 4. Eliminar la infraestructura creada
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
