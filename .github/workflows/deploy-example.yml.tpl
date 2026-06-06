name: Deploy Node App
run-name: 🚀 Hello!, we're deploying the ${{ github.event.pull_request.user.login }}'s changes

on:
  pull_request:
    types: [closed]
    branches:
      - main

jobs:
  call-central-workflow:
    # Solo ejecuta el workflow si el pull request ha sido cerrado y fusionado
    if: github.event.pull_request.merged == true
    # IMPORTANTE: Reemplaza con el nombre de tu repo y ruta a utilizar
    uses: Leiva07/urb-workflows/.github/workflows/node-docker-pipeline.yml@main
    with:
      aws-region: ${{ vars.AWS_REGION }}
      ecr-repository: 'urbana'
      # image-tag: ${{ github.sha }} # Usa el ID del commit como etiqueta única, default: latest
      ecs-cluster: 'urbana-cluster' # <--- Agrega el nombre de tu Clúster ECS
      ecs-service: 'urbana' # <--- Agrega el nombre de tu Servicio ECS
    secrets: inherit