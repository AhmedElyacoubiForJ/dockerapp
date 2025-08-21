#!/bin/bash
# 🛑 Container stoppen + Cleanup-Skript aufrufen

echo "📦 docker-compose wird heruntergefahren..."
docker compose down --volumes --remove-orphans

echo "🧼 Starte docker-clean.sh..."
./docker-clean.sh

echo "✅ Container gestoppt & Docker aufgeräumt"
