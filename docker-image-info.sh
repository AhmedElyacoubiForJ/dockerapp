#!/bin/bash

IMAGE="$1"

if [ -z "$IMAGE" ]; then
  echo "❌ Bitte gib ein Image-Tag an. Beispiel: ./docker-info.sh myapp:slim-container"
  exit 1
fi

echo "🔍 Docker Image Info für: $IMAGE"
echo "----------------------------------"

# Inspect
echo "🧾 Allgemeine Informationen:"
docker image inspect "$IMAGE" --format '
ID: {{.Id}}
Erstellt: {{.Created}}
Größe: {{.Size}} Bytes
Architektur: {{.Architecture}}
OS: {{.Os}}
Entrypoint: {{json .Config.Entrypoint}}
CMD: {{json .Config.Cmd}}
WorkingDir: {{.Config.WorkingDir}}
Healthcheck: {{range .Config.Healthcheck.Test}}{{.}} {{end}}
' | sed 's/\\n/\n/g'

echo ""
echo "📜 Layer-Historie:"
docker history "$IMAGE" --format '{{.CreatedBy}} | {{.Size}} | {{.Comment}}' | head -n 10

echo ""
echo "✅ Fertig."
