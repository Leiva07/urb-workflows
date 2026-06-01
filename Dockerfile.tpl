# ===================================================================================
# ETAPA 1: Constructor (Builder) ## TODO: actualizar a la versión de Node que se usa.
# ===================================================================================
FROM node:18-alpine AS builder

WORKDIR /app

# 1. Copiamos los archivos de dependencias
COPY package*.json ./

# 2. Instalamos TODAS las dependencias (incluyendo devDependencies para compilar)
RUN npm ci

# 3. Copiamos todo el código fuente
COPY . .

# 4. Compilamos el código.
RUN npm run build || true

# ==============================================================================================
# ETAPA 2: Producción (Imagen Final Ligera) ## TODO: actualizar a la versión de Node que se usa.
# ==============================================================================================
FROM node:18-alpine

# Establecemos entorno de producción
ENV NODE_ENV=production
WORKDIR /app

# 1. Copiamos dependencias de nuevo
COPY package*.json ./

# 2. Instalamos SOLO dependencias de producción
RUN npm ci --omit=dev

# 3. Copiamos SOLO los archivos compilados o necesarios de la etapa 'builder'
# Asumiendo que tu código transpilado va a una carpeta 'dist'.
COPY --from=builder /app/dist ./dist

# 4. Exponemos el puerto que necesita tu app (TODO: Actualizar si se usa otro puerto)
EXPOSE 3000

# 5. Comando para iniciar la aplicación
CMD ["node", "dist/index.js"]