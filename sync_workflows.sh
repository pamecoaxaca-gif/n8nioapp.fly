#!/bin/sh

# Directorios
N8N_DIR="/home/node/.n8n"
GIT_WORKFLOWS_DIR="/home/node/n8n-data"

# Exportar workflows desde n8n a Git
export_workflows() {
  echo "Exportando workflows desde n8n a Git..."
  mkdir -p "$GIT_WORKFLOWS_DIR"
  cp -r "$N8N_DIR"/workflows/* "$GIT_WORKFLOWS_DIR"/
  cp "$N8N_DIR"/config "$GIT_WORKFLOWS_DIR"/
  cd "$GIT_WORKFLOWS_DIR"
  git add .
  git commit -m "Actualizar workflows desde n8n"
  git push origin main
}

# Importar workflows desde Git a n8n
import_workflows() {
  echo "Importando workflows desde Git a n8n..."
  mkdir -p "$N8N_DIR"
  cp -r "$GIT_WORKFLOWS_DIR"/workflows/* "$N8N_DIR"/workflows/
  cp "$GIT_WORKFLOWS_DIR"/config "$N8N_DIR"/
}

# Ejecutar según el argumento
case "$1" in
  export)
    export_workflows
    ;;
  import)
    import_workflows
    ;;
  *)
    echo "Uso: $0 {export|import}"
    exit 1
    ;;
esac
