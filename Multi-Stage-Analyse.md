
# 🐳 Docker Analyse-Dokumentation

## 📦 Image-Analyse: `myapp:slim-container`

```bash
docker image inspect myapp:slim-container
```

### 🔍 Zweck:
Zeigt Metadaten des Images wie:
- **RepoTags**: `myapp:slim-container`
- **Architecture**: `amd64`
- **Os**: `linux`
- **Entrypoint**: z.B. `["java"]`
- **Cmd**: z.B. `["-jar", "/app/app.jar"]`
- **Size**: z.B. `120MB` (je nach Build)
- **Layers**: Multi-Stage Build sichtbar

---

## 🚀 Container-Analyse: `demo-app`

```bash
docker ps
docker inspect demo-app
```

### 🔍 Zweck:
Ermittelt Laufzeitinformationen wie:
- **Name**: `demo-app`
- **Id**: z.B. `34ba4681a3e2`
- **State**: `"Running"`
- **Image**: `myapp:slim-container`
- **Config.Cmd**: `["java", "-jar", "/app/app.jar"]`
- **NetworkSettings.IPAddress**: z.B. `172.17.0.2`
- **Mounts**: Keine (wenn nicht gesetzt)

---

## 📁 Speicherplatz-Analyse im Container

### 1. Container betreten

```bash
docker exec -it demo-app /bin/bash
```

### 2. Verzeichnisgrößen anzeigen

```bash
du -sh /* 2>/dev/null | sort -hr | head -n 10
```

### 3. Inhalt von `/app` prüfen

```bash
ls -lh /app
```

### 4. Nicht vorhandene Verzeichnisse prüfen

```bash
ls -lh /src
ls -lh /target
ls -lh /mvn
```

### 5. Suche nach unnötigen Dateien

```bash
find / -type f \( -name "*.log" -o -name "*.iml" -o -name ".DS_Store" \) 2>/dev/null
```

### 6. Größte Dateien im Container

```bash
find / -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 20
```

---

## ✅ Ergebniszusammenfassung

- Keine Build-Artefakte wie `/src`, `/target`, `/mvn`
- Keine `.log`, `.iml`, `.DS_Store` außerhalb von Systempfaden
- Hauptspeicherverbrauch durch:
    - `/opt/java/openjdk/lib/modules` (~81MB)
    - `/app/app.jar` (~25MB)
    - JVM-Bibliotheken unter `/opt` und `/usr/lib`

---

📌 *Hinweis*: Diese Analyse bestätigt, dass der Multi-Stage Build erfolgreich war und keine unnötigen Dateien im Container vorhanden sind.