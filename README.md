# Curso Terraform

Bienvenido al curso de Terraform. Este repositorio contiene ejemplos básicos y comandos esenciales para iniciar tu flujo de trabajo con Terraform.

## Requisitos

- Tener instalado `terraform` en tu sistema.
- Ejecutar los comandos desde el directorio raíz del curso.

## Inicio rápido

```sh
# Prepara tu directorio de trabajo para otros comandos
terraform init
```

## Comandos principales de Terraform

- `init`      : Prepara tu directorio de trabajo para otros comandos.
- `validate`  : Verifica si la configuración es válida.
- `plan`      : Muestra los cambios que se aplicarán.
- `apply`     : Crea o actualiza la infraestructura.
- `destroy`   : Elimina la infraestructura creada.

## Otros comandos útiles

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

## Recomendación

Ejecuta `terraform init` antes de usar `plan`, `apply` o `destroy` para asegurarte de que el directorio de trabajo esté correctamente configurado.
