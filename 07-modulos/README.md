# 🏗️ 07-modulos — EC2 con arquitectura modular en Terraform

Este módulo es una versión refactorizada de `06-ec2/`, reescrita siguiendo las buenas prácticas
oficiales de Terraform para separar responsabilidades en módulos reutilizables e independientes.

---

## 📁 Estructura del proyecto

```
07-modulos/
├── 📄 provider.tf              # Configuración de Terraform y provider de AWS
├── 📄 variables.tf             # Variables de entrada del root module
├── 📄 locals.tf                # Valores calculados: name_prefix y common_tags
├── 📄 main.tf                  # Orquestación de los tres módulos
├── 📄 outputs.tf               # Outputs exportados al usuario
├── 📄 terraform.tfvars         # Valores reales (key_name, etc.)
├── 📄 terraform.tfvars.example # Plantilla de ejemplo para nuevos entornos
└── 📦 modules/
    ├── 🌐 networking/          # VPC, Subnet, Internet Gateway, Route Table
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── 🔒 security/            # Security Groups
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── 💻 compute/             # AMI lookup + instancias EC2
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## 🧩 Módulos

### 🌐 `modules/networking`

Gestiona toda la infraestructura de red necesaria para exponer instancias a internet.

| Recurso | Descripción |
|---------|-------------|
| `aws_vpc` | Red privada virtual con DNS habilitado |
| `aws_subnet` | Subnet pública dentro de la VPC |
| `aws_internet_gateway` | Puerta de enlace a internet |
| `aws_route_table` | Tabla de rutas con ruta `0.0.0.0/0` al IGW |
| `aws_route_table_association` | Asocia la subnet a la route table |

**Inputs principales:** `vpc_cidr`, `subnet_cidr`, `availability_zone`, `name_prefix`, `common_tags`

**Outputs:** `vpc_id`, `subnet_id`

---

### 🔒 `modules/security`

Define las reglas de acceso de red para las instancias EC2.

| Recurso | Descripción |
|---------|-------------|
| `aws_security_group` | Permite tráfico HTTP entrante (puerto 80) y toda salida |

**Inputs principales:** `vpc_id`, `name_prefix`, `common_tags`

**Outputs:** `security_group_id`

---

### 💻 `modules/compute`

Busca la AMI más reciente de Amazon Linux 2023 y lanza las instancias EC2.

| Recurso | Descripción |
|---------|-------------|
| `data.aws_ami` | Lookup dinámico de la AMI más reciente de Amazon Linux 2023 |
| `aws_instance` | Instancias EC2 con Apache preinstalado via `user_data` |

**Inputs principales:** `instance_type`, `instance_count`, `subnet_id`, `security_group_ids`, `key_name`, `name_prefix`, `common_tags`

**Outputs:** `instance_ids`, `public_ips`, `web_urls`

---

## ⚙️ Root Module

El `main.tf` raíz actúa como **orquestador**: no define recursos directamente, solo invoca los módulos
pasando los valores correctos y conectando sus outputs como inputs entre sí.

```
networking  ──(vpc_id, subnet_id)──▶  security
                                  ──▶  compute
security    ──(security_group_id)──▶  compute
```

El `locals.tf` centraliza dos valores reutilizados por todos los módulos:

- `name_prefix` — concatenación de `project_name` + `environment` (ej: `tfcourse-dev`)
- `common_tags` — mapa de etiquetas compartidas por todos los recursos

---

## 🚀 Uso

### 1. Copiar y configurar variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars con tu key_name y valores deseados
```

### 2. Inicializar y desplegar

```bash
terraform init
terraform plan
terraform apply
```

### 3. Ver outputs

```bash
terraform output web_urls
terraform output instance_public_ips
```

### 4. Destruir infraestructura

```bash
terraform destroy
```

---

## 🔄 Diferencias respecto a `06-ec2/`

| Aspecto | `06-ec2/` | `07-modulos/` |
|---------|-----------|---------------|
| Organización | Todo en un solo `main.tf` | Separado en 3 módulos independientes |
| Reutilización | No reutilizable | Cada módulo es invocable por separado |
| `required_version` | No definido | Sí (`>= 1.8.0`) |
| Versión del provider | Fijada exacta (`6.41.0`) | Rango flexible (`~> 6.41`) |
| Outputs de URLs | Expresión `[0]` frágil | Expresión `for` sobre todos los IPs |
| `name_prefix` | Repetido en cada recurso | Centralizado en `locals.tf` |
| `description` en SG rules | Ausente | Presente en ingress y egress |

---

## 🏷️ Etiquetas aplicadas a todos los recursos

Definidas en `locals.tf` y propagadas vía `common_tags`:

| Tag | Valor |
|-----|-------|
| `Organization` | `var.org_name` |
| `Project` | `var.project_name` |
| `Environment` | `var.environment` |
| `Owner` | `felipe` |
| `CreatedBy` | `terraform` |

---

## 📋 Variables disponibles

| Variable | Tipo | Default | Requerida |
|----------|------|---------|-----------|
| `region` | string | `us-east-1` | No |
| `org_name` | string | `felipecorp` | No |
| `project_name` | string | `tfcourse` | No |
| `environment` | string | `dev` | No |
| `key_name` | string | — | **Sí** |
| `instance_type` | string | `t3.micro` | No |
| `instance_count` | number | `1` | No |
