#!/bin/bash

# ./scripts/scan_sources.sh mycontainer-eclipse-temurin

CONTAINER=$1

echo "🔍 Scanne Container: $CONTAINER"

docker exec "$CONTAINER" sh -c 'find / -type f \( -name "*.java" -o -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.go" \) 2>/dev/null' > scan_result.txt

if [ -s scan_result.txt ]; then
  echo "📁 Source-Dateien gefunden:"
  cat scan_result.txt
else
  echo "✅ Keine Source-Dateien gefunden."
fi
