FROM n8nio/n8n:latest

# Instala cron en Alpine (usando apk)
RUN apk add --no-cache dcron

# Crea el directorio para los datos de n8n
RUN mkdir -p /home/node/.n8n

# Copia el script de sincronización
COPY sync_workflows.sh /usr/local/bin/sync_workflows.sh
RUN chmod +x /usr/local/bin/sync_workflows.sh

# Copia los workflows predefinidos desde el repositorio
COPY ./n8n-data /home/node/.n8n

# Configura permisos
RUN chown -R node:node /home/node/.n8n

# Configura el cron job para exportar workflows cada 5 minutos (opcional)
RUN echo "*/5 * * * * /usr/local/bin/sync_workflows.sh export >> /var/log/cron.log 2>&1" | crontab -

# Expone el puerto de n8n
EXPOSE 5678

# Inicia cron junto con n8n (en Alpine, dcron se inicia con crond)
CMD ["sh", "-c", "crond && n8n"]
