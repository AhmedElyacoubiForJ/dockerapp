#!/bin/bash

# ./scripts/analyze_mounts.sh mycontainer-eclipse-temurin

CONTAINER=$1

echo "🔍 Prüfe Mounts für Container: $CONTAINER"
docker inspect "$CONTAINER" --format='{{json .Mounts}}' | jq

echo -e "\n📁 Prüfe Entwicklungsverzeichnisse:"
docker exec "$CONTAINER" sh -c 'ls -d /app /usr/src /workspace /mnt /code 2>/dev/null'

echo -e "\n📄 Zeige Beispiel-Dateien in Dev-Verzeichnissen:"
docker exec "$CONTAINER" sh -c 'find /app /usr/src /workspace /mnt /code -type f 2>/dev/null | head -n 20'
