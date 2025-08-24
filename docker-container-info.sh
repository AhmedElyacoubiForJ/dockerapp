#!/bin/bash

# Containername als Parameter
CONTAINER_NAME="$1"

# Prüfen, ob Parameter gesetzt ist
if [ -z "$CONTAINER_NAME" ]; then
  echo "❌ Fehler: Bitte Containername als Parameter übergeben."
  echo "➡️ Beispiel: ./docker-container-info.sh demo-app"
  exit 1
fi

echo "🔍 Container-Analyse für: $CONTAINER_NAME"
echo "----------------------------------------"

# Allgemeine Container-Infos
docker inspect "$CONTAINER_NAME" | jq '.[0] | {
  ID: .Id,
  Name: .Name,
  Image: .Config.Image,
  State: .State.Status,
  StartedAt: .State.StartedAt,
  IPAddress: .NetworkSettings.IPAddress,
  Cmd: .Config.Cmd
}'

echo ""
echo "📁 Speicherplatzübersicht im Container:"
docker exec "$CONTAINER_NAME" du -sh /* 2>/dev/null | sort -hr | head -n 10

echo ""
echo "📦 Inhalt von /app:"
docker exec "$CONTAINER_NAME" ls -lh /app

echo ""
echo "🔍 Prüfung auf Build-Reste:"
docker exec "$CONTAINER_NAME" ls -lh /src /target /mvn 2>/dev/null

echo ""
echo "🧹 Suche nach unnötigen Dateien:"
docker exec "$CONTAINER_NAME" find / -type f \( -name "*.log" -o -name "*.iml" -o -name ".DS_Store" \) 2>/dev/null

echo ""
echo "📊 Größte Dateien im Container:"
docker exec "$CONTAINER_NAME" find / -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 20
