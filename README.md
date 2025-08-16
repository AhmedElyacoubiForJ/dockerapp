# 🚀 Spring Boot + 🐳 Docker (PostgreSQL) – Mini-Projekt

Ein einfaches Beispielprojekt, bei dem eine lokal laufende Spring Boot-Anwendung auf eine PostgreSQL-Datenbank im Docker-Container zugreift.

## 📁 Projektstruktur
```text
projekt-root/
├── .env.template               # ✅ Vorlage für Umgebungsvariablen (nicht geheim)
├── .env                        # 🔐 Echte Umgebungsvariablen (nicht ins Repo!)
├── .env-config                 # 📦 Pfad-Konfiguration für update_env_ip.sh
├── .gitignore                  # ➕ Ignoriert .env, .env-config und sensible Dateien
├── docker-compose.yml          # 🐳 Docker-Setup für PostgreSQL-Datenbank
├── start_postgres.sh           # 🔄 Startet den PostgreSQL-Container
├── update_env_ip.sh            # 🌐 Aktualisiert IP-Adresse in .env
├── pom.xml                     # 📦 Maven-Konfiguration für das Java-Projekt
├── README.md                   # 📘 Projektbeschreibung & Anleitung
└── src/
    └── main/
        └── java/
            └── edu/yacoubi/dockerapp/
                └── DockerDemoApplication.java  # 🚀 Einstiegspunkt der Spring Boot App
```

---

## 🔧 Setup & Konfiguration

### 1. Umgebungsvariablen (.env)

Die Anwendung benötigt eine `.env`-Datei mit Konfigurationswerten.  
Kopiere die Vorlage und ergänze deine Werte:

```bash
cp .env.example .env
```

Bearbeite anschließend .env und trage deine Datenbank- und App-Konfiguration ein.


### 2. Pfad-Konfiguration für Skripte (.env-config)

Einige Skripte (z.B. update_env_ip.sh) benötigen den Pfad zur .env-Datei. Kopiere die Vorlage und passe den Pfad an dein System an

```bash
cp .env-config.template .env-config
```

Bearbeite `.env-config` und setze deinen echten Pfad:

```text
ENV_FILE_PATH="/mnt/c/Users/DEIN_NAME/DEIN_PROJEKT/dockerapp/.env"
```

## 🪜 Schritte zur Ausführung

### 🔄 1. start_postgres.sh (🐳 PostgreSQL)

Startet den PostgreSQL-Container – wird bei jedem `IntelliJ-Start` im `Ubuntu-Terminal` ausgeführt.

```bash
./start_postgres.sh
```

### 🌐 2. update_env_ip.sh

Aktualisiert die IP-Adresse in `.env`, nur wenn sich die Netzwerk-IP geändert hat (z.B. nach Router-Neustart).

```bash
./update_env_ip.sh
```
🔐 Dadurch bleibt die Verbindung zur Datenbank stabil, ohne unnötige Änderungen.

---

### App im Browser öffnen

```
http://localhost:8080
```

## ✅ Ergebnis

Die Anwendung läuft lokal in IntelliJ und ist erreichbar unter:

- 🌐 `http://localhost:8080/api/hello`
- 🧪 oder per `curl`: ```bash curl http://localhost:8080/api/hello```

Zusätzlich liefert der Endpunkt /db-info Informationen zur Datenbankverbindung

- 🌐 `http://localhost:8080/db-info`
- 🧪 oder per `curl`: ```bash curl http://localhost:8080/db-info```

### 📦 Beispielausgabe:

```json 
{
  "ip": "172.17.0.2",
  "database": "postgres",
  "user": "postgres"
}
```
