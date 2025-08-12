FROM n8nio/n8n:latest

# Crea el directorio para los datos de n8n
RUN mkdir -p /home/node/.n8n

# Copia los workflows iniciales desde el repositorio (si existen)
COPY ./n8n-data /home/node/.n8n

# Instala cron
RUN apt-get update && apt-get install -y cron

# Agrega el script al contenedor
COPY sync_workflows.sh /usr/local/bin/sync_workflows.sh
RUN chmod +x /usr/local/bin/sync_workflows.sh

# Configura el cron job para exportar workflows cada 5 minutos
RUN echo "*/5 * * * * /usr/local/bin/sync_workflows.sh export >> /var/log/cron.log 2>&1" | crontab -

# Inicia cron junto con n8n
CMD ["sh", "-c", "service cron start && n8n"]

# Configura permisos
RUN chown -R node:node /home/node/.n8n

# Expone el puerto de n8n
EXPOSE 5678

# Comando para iniciar n8n
CMD ["n8n"]
