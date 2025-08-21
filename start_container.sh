#!/bin/bash

# .env laden
export $(grep -v '^#' .env | xargs)

# servers.json generieren
envsubst < servers.template.json > servers.json

# .pgpass generieren
echo "${DB_HOST}:${DB_PORT}:${DB_NAME}:${DB_USER}:${DB_PASSWORD}" > .pgpass
chmod 600 .pgpass

# Docker Compose starten
docker compose up --build




##!/bin/bash
#
## .env laden
#export $(grep -v '^#' .env | xargs)
#
## pgpass generieren (optional)
#echo "${DB_HOST}:${DB_PORT}:*:${DB_USER}:${DB_PASSWORD}" > .pgpass
#chmod 600 .pgpass
#
## Docker Compose starten
#docker compose up --build