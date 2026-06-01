name: Deploy Node App

on:
  push:
    branches:
      - main # Se ejecuta cuando hay cambios en la rama principal

jobs:
  call-central-workflow:
    # IMPORTANTE: Reemplaza 'tu-usuario/central-workflows' con el nombre real de tu repo y ruta
    uses: tu-usuario/central-workflows/.github/workflows/build-and-push-ecr.yml@main
    with:
      ecr-repository: 'mi-app-renta-autos'
      image-tag: ${{ github.sha }} # Usa el ID del commit como etiqueta única