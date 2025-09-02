#!/bin/bash

echo "📦 Docker Speicherstatus:"
docker system df

echo -e "\n🧹 Bereinige Build-Cache, falls nötig..."
docker builder prune -f

echo -e "\n🧹 Bereinige nicht verwendete Volumes..."
docker volume prune -f

echo -e "\n🧹 Bereinige nicht verwendete Images & Container..."
docker system prune -f --volumes
