# 🐳 Docker-compose-file – Kontext und Zweck

## 📦 Wann ist dieses docker-compose.yml relevant?
> Immer dann, wenn die Anwendung lokal oder in Entwicklungsumgebungen 
> als Container gestartet werden soll – inkl. Datenbank und Admin-Oberfläche.

---

## 🔧 Was tut dieses Compose-Setup?
> Es startet drei Container:
>  1. PostgreSQL-Datenbank
>  2. pgAdmin zur Verwaltung der Datenbank
>  3. Eine Spring Boot Anwendung, die mit der Datenbank kommuniziert

---

## 🔄 Wie passt es in den Gesamt-Workflow?
> Nach dem Bauen der App mit Maven (`mvn clean package`) wird die Anwendung 
> über Docker Compose gestartet. Die Datenbank wird automatisch bereitgestellt, 
> und pgAdmin bietet eine visuelle Oberfläche zur Kontrolle. 
> Ideal für lokale Entwicklung, Tests und erste CI/CD-Schritte.

---

## 🛠️ Voraussetzungen:
> → Eine `.env` Datei mit den nötigen Variablen (DB-Name, User, Passwort)
> → Ein Dockerfile im Projektverzeichnis für die Spring Boot App

---

## 🐳 Dockerfile - code
> Erstellt ein schlankes Java-Image mit der App
```yml
version: '3.8'

services:
  db:
    image: postgres:16
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://db:5432/${POSTGRES_DB}
      SPRING_DATASOURCE_USERNAME: ${POSTGRES_USER}
      SPRING_DATASOURCE_PASSWORD: ${POSTGRES_PASSWORD}
    depends_on:
      - db

  pgadmin:
    image: dpage/pgadmin4
    ports:
      - "8081:80"
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@admin.com
      PGADMIN_DEFAULT_PASSWORD: secret
    depends_on:
      - db
      
volumes:
  pgdata:

```

## 🌐 Ports:
> → App:      [DemoApp](http://localhost:8080)
> → pgAdmin:  [DB-Client](http://localhost:8081)