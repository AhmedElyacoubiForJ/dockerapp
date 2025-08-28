## 🧼 **Container & Images aufräumen: sinnvoll?**

Wenn man zwischen lokalem Setup und Docker-Setup wechselst, ist es oft hilfreich, einmal „frisch“ zu starten. So vermeidest du:

- Alte Umgebungsvariablen, die noch im Container hängen
- Caches oder Volumes, die falsche Daten liefern
- Images, die nicht zur aktuellen Konfiguration passen

---

## 🔧 **Was du konkret tun kannst**

### 1. **Container stoppen & entfernen**

```bash
docker ps -a          # Zeigt alle Container
docker stop <ID>      # Stoppt laufende Container
docker rm <ID>        # Entfernt Container
```

Oder alles auf einmal:

```bash
docker container prune
```

➡️ Entfernt alle gestoppten Container.

---

### 2. **Images löschen (optional)**

Wenn du sicher bist, dass du ein Image nicht mehr brauchst:

```bash
docker images         # Zeigt alle Images
docker rmi <Image-ID> # Entfernt ein Image
```

Oder:

```bash
docker image prune -a
```

➡️ Entfernt alle ungenutzten Images.

---

### 3. **Volumes aufräumen (wenn du z. B. Datenbanken neu starten willst)**

```bash
docker volume prune
```

➡️ Entfernt ungenutzte Volumes. Vorsicht: Wenn du persistente Daten brauchst, vorher sichern!

---

### 4. **Neu bauen & starten**

Wenn du alles bereinigt hast:

```bash
docker compose -f compose/docker-compose-openjdk-slim.yml up --build -d
```

➡️ Erzwingt einen Neuaufbau der Images und startet die Container im Hintergrund.

---

## 🧠 Bonus-Tipp: `.env` richtig nutzen

Wenn `DB_PASSWORD` nicht gesetzt ist, bekommst du die Warnung:

```bash
WARN[0000] The "DB_PASSWORD" variable is not set. Defaulting to a blank string.
```

Lösung: In deiner `.env`-Datei sicherstellen, dass du z. B. Folgendes hast:

```env
DB_PASSWORD=meinPasswort123
```

Und in `docker-compose-openjdk-slim.yml` sollte die Variable auch referenziert werden:

```yaml
environment:
  - DB_PASSWORD=${DB_PASSWORD}
```