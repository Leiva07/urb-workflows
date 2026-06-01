# Urbana Workflows Centralizados

Este repositorio contiene una colección de **GitHub Actions Reutilizables** diseñadas para estandarizar los procesos de CI/CD en los diferentes proyectos de Urbana.

Al centralizar los workflows, facilitamos el mantenimiento y aseguramos que todos los microservicios sigan las mismas reglas de compilación, seguridad y despliegue.

## Workflows Disponibles

### 1. Build and Push to Amazon ECR (`node-docker-pipeline.yml`)
Este workflow se encarga de clonar el código de una aplicación, construir la imagen de Docker y subirla a un repositorio de Amazon ECR.

#### Entradas (Inputs)
| Parámetro | Descripción | Requerido | Default |
|-----------|-------------|-----------|---------|
| `aws-region` | Región de AWS donde se encuentra el ECR. | Sí | - |
| `ecr-repository` | Nombre del repositorio ECR de destino. | Sí | - |
| `image-tag` | Etiqueta para la imagen de Docker. | No | `latest` |

#### Secretos (Secrets)
| Secreto | Descripción | Requerido |
|---------|-------------|-----------|
| `aws-access-key-id` | ID de la llave de acceso de AWS. | Sí |
| `aws-secret-access-key` | Llave secreta de acceso de AWS. | Sí |

---

## Cómo utilizar estos workflows

Para llamar a un workflow de este repositorio desde otro repositorio de la organización, utiliza la sintaxis `uses` dentro de tu archivo de GitHub Action.

### Ejemplo de implementación

Crea un archivo en tu repositorio de aplicación (ej. `.github/workflows/deploy.yml`):

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    # Referencia al workflow reutilizable en este repo
    uses: urbana-org/urb-workflows/.github/workflows/node-docker-pipeline.yml@main
    with:
      aws-region: "us-east-1"
      ecr-repository: "mi-aplicacion-repo"
      image-tag: ${{ github.sha }}
    secrets:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

## Requisitos para los Repositorios Hijos

1. **Permisos:** El repositorio que llama debe tener permisos de lectura sobre este repositorio de workflows.
2. **Dockerfile:** Para el workflow de ECR, el repositorio de la aplicación debe contener un archivo `Dockerfile` en su raíz.
3. **Secretos:** Asegúrate de configurar los secretos de AWS en el repositorio de la aplicación o a nivel de organización.

## Contribución

Si deseas agregar un nuevo workflow reutilizable:
1. Crea el archivo `.yml` en `.github/workflows/`.
2. Asegúrate de que el disparador sea `on: workflow_call`.
3. Documenta los inputs y secrets en este README.

---
*Mantenido por el equipo de DevOps de Urbana.*
