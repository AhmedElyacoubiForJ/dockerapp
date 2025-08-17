# 🚀 🐳 Docker (Spring Boot App & PostgreSQL) – Mini-Container-Projekt

Dieses Branch enthält eine dockerisierte Version unserer Spring Boot Anwendung.  
Im Gegensatz zur `main`-Branch, wo die App lokal läuft und auf eine PostgreSQL-Datenbank im Docker-Container zugreift 🐳,  
werden hier **App und Datenbank gemeinsam in Containern** betrieben.

---

## 📦 Ziel dieses Branches

- Die App läuft selbst im Docker-Container
- PostgreSQL wird ebenfalls über Docker bereitgestellt
- Keine zusätzlichen Dienste wie Redis, RabbitMQ etc.
- Grundlage für ein vollständiges, containerisiertes Setup

---

## 📁 Projektstruktur (vereinfacht)

```text
.
├── Dockerfile                # Containerisierung der App
├── docker-compose.yml        # App & PostgreSQL gemeinsam starten
├── .env                      # Umgebungsvariablen
├── README.md                 # Diese Datei
└── src/                      # Quellcode der Spring Boot App

```

---

## 🛠️ Voraussetzungen

- [Docker](https://www.docker.com/) installiert

---

## ▶️ Anwendung starten

```bash
docker compose up --build
```

Hinweis: Die Konfiguration erfolgt über docker-compose.yml und Dockerfile.

---

## 🌐 Zugriff

Nach dem Start ist die App erreichbar unter:

```text
http://localhost:8080
```

Testendpunkte:

```bash
curl http://localhost:8080/api/hello
curl http://localhost:8080/db-info
```

Beispielausgabe:

```json
{
  "ip": "172.17.0.2",
  "database": "postgres",
  "user": "postgres"
}
```

---

## 📌 Hinweis

Diese Version dient als Grundlage für ein vollständiges Docker-Setup. Erweiterungen mit weiteren Diensten (Redis, RabbitMQ etc.) erfolgen in separaten Branches.
Für die klassische lokale Entwicklung siehe Branch [`main`](https://github.com/AhmedElyacoubiForJ/dockerapp/tree/main).
