#!/bin/bash

echo "🚀 Starte alle gestoppten Container (außer db & app)..."
docker ps -a --filter "status=exited" --format "{{.Names}}" | while read name; do
  if [ "$name" != "db_container" ] && [ "$name" != "mycontainer-eclipse-temurin" ]; then
    echo "➡️ Starte $name"
    docker start "$name"
  fi
done

echo "🚀 Starte db_container..."
docker start db_container

echo "⏳ Warte, bis PostgreSQL bereit ist..."
until docker exec db_container pg_isready -U postgres > /dev/null 2>&1; do
  echo "🔄 PostgreSQL noch nicht bereit..."
  sleep 2
done

echo "✅ PostgreSQL ist bereit!"

echo "🚀 Starte mycontainer-eclipse-temurin..."
docker start mycontainer-eclipse-temurin

echo "🏁 Alle relevanten Container wurden gestartet."
