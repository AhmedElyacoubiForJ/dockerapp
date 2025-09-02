#!/bin/bash

# 🔧 ENV-Auswahl
#ENV="$1"
#if [ -z "$ENV" ]; then
#  echo "❌ Bitte Umgebung angeben: dev, test, prod"
#  exit 1
#fi

#ENV_FILE=".env.$ENV"
ENV_FILE=".env"
COMPOSE_DIR="./compose"

# 📦 Varianten definieren
VARIANTEN=("eclipse-temurin" "openjdk-slim")

# 🧹 Cleanup
echo "🧹 Entferne alte Container..."
for variant in "${VARIANTEN[@]}"; do
  docker rm -f "mycontainer-$variant" 2>/dev/null
done
docker rm -f db_container 2>/dev/null

echo "🧼 Entferne alte Netzwerke & Volumes..."
docker volume prune -f
docker network prune -f

# 🚀 Starte alle Varianten
for variant in "${VARIANTEN[@]}"; do
  echo "🚀 Starte Variante: $variant"
  docker compose --env-file "$ENV_FILE" -f "$COMPOSE_DIR/docker-compose-$variant.yml" up -d
done

# 🧠 Optional: Analyse-Skript starten
echo "🔍 Starte Analyse..."
./analyze-containers.sh "$ENV"
