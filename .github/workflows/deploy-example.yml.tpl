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
      aws-region: 'us-east-1' # Cambia por tu región
      ecr-repository: 'mi-app-renta-autos'
      image-tag: ${{ github.sha }} # Usa el ID del commit como etiqueta única
    secrets:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}