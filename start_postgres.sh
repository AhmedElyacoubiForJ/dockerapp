#!/bin/bash

echo "📦 Starte Postgres-Container mit .env..."

# .env laden
source .env

# Container-Name
CONTAINER_NAME="postgres-db"

# Prüfen, ob Container existiert
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "🛑 Stoppe und entferne bestehenden Container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Container starten
echo "🚀 Starte neuen Container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p 5432:5432 \
  -e POSTGRES_DB=$POSTGRES_DB \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -v pgdata:/var/lib/postgresql/data \
  postgres:16

echo "✅ Postgres läuft jetzt unter Port 5432"
