FROM n8nio/n8n:latest

# Crea el directorio para los datos de n8n
RUN mkdir -p /home/node/.n8n

# Copia los workflows iniciales desde el repositorio (si existen)
COPY ./n8n-data /home/node/.n8n

# Configura permisos
RUN chown -R node:node /home/node/.n8n

# Expone el puerto de n8n
EXPOSE 5678

# Comando para iniciar n8n
CMD ["n8n"]
