#!/bin/bash
# 🧼 Aufräumen & Neustart

echo "🧹 Entferne gestoppte Container..."
docker container prune -f

echo "🧹 Entferne ungenutzte Images..."
docker image prune -a -f

echo "🧹 Entferne ungenutzte Volumes..."
docker volume prune -f

echo "🔧 Baue das Image neu..."
docker build -f ./dockerfiles/Dockerfile.openjdk-slim -t myimage:openjdk-slim .

echo "🚀 Starte Compose neu..."
docker compose -f compose/docker-compose-openjdk-slim.yml up --build -d

echo "✅ Docker-Umgebung wurde zurückgesetzt und neu gestartet."
