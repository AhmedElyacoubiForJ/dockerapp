# 🐳 Docker-Befehle – Zusammenfassung

## 📦 Container-Verwaltung

### Container starten
```bash
docker compose up
```

### Container starten und neu bauen
```bash
docker compose up --build
```

### Container stoppen und entfernen
```bash
docker compose down
```

### Container stoppen inkl. Volumes und Orphans
```bash
docker compose down --volumes --remove-orphans
```

### Container neu bauen
```bash
docker compose build
```

---

## 🔍 Container-Status und Healthchecks

### Aktive Container anzeigen
```bash
docker ps
```

### Health-Status eines Containers prüfen
```bash
docker inspect --format='{{json .State.Health}}' <container-name>
```

Beispiel:
```bash
docker inspect --format='{{json .State.Health}}' demo-app
```

---

## 🧪 Manuelle Tests im Container

### In Container bash öffnen
```bash
docker exec -it <container-name> bash
```

Beispiel:
```bash
docker exec -it demo-app bash
```

### Manuell Healthcheck ausführen
```bash
curl -f http://localhost:8080/actuator/health
```

---

> Diese Befehle bilden die Grundlage für dein `devops-container-core` Setup und helfen dir, 
> Container sauber zu starten, zu überwachen und zu verwalten.