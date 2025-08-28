# 🚀 — **finaler Check** für `docker-compose-openjdk-slim.yml`, inklusive aller relevanten Befehle, die man braucht, um das Setup **vollständig zu testen und zu validieren**.


---

## ✅ **Letzter Check: docker-compose-openjdk-slim.yml**

### 🔍 Struktur & Konfiguration

| Bereich             | Status | Hinweise |
|---------------------|--------|----------|
| `app` Service       | ✅     | Image, Ports, Healthcheck, Env-Variablen korrekt |
| `db` Service        | ✅     | PostgreSQL 16, Volumes, Env-Variablen sauber |
| Volumes             | ✅     | `pgdata` persistent |
| Healthcheck         | ✅     | Actuator-URL, sinnvolle Intervalle |
| Env-Variablen       | ⚠️     | Stelle sicher, dass `.env` oder `.env.dev` die Variablen enthält: `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_APP` |

---

## 🧪 **Nützliche Befehle für vollständigen Check**

### 🚀 **Starten & Bauen**

```bash
# Mit Standard .env
docker compose --env-file .env -f compose/docker-compose-openjdk-slim.yml up --build -d

# Mit dev-Umgebung
docker compose --env-file .env.dev -f compose/docker-compose-openjdk-slim.yml up --build -d
```

### 📦 **Container-Status prüfen**

```bash
docker ps
docker compose ps
```

### 🧠 **Healthcheck manuell prüfen**

```bash
curl http://localhost:8080/actuator/health?details=true
```

### 🗄️ **PostgreSQL direkt testen**

```bash
docker exec -it db_container psql -U postgres -d postgres
# Im psql:
SELECT current_database();
```

### 📜 **Spring Boot Logs prüfen**

```bash
docker logs mycontainer
```

### 🔄 **Neu starten / stoppen**

```bash
docker compose down
docker compose restart
```

### 🧹 **Container & Volumes komplett entfernen (optional)**

```bash
docker compose down -v
```

### 🧾 **Environment-Variablen prüfen**

```bash
cat .env
cat .env.dev
```

---

## 🧠 Bonus-Tipp: `.env` Strukturbeispiel

```dotenv
DB_HOST=db
DB_PORT=5432
DB_NAME=postgres
DB_USER=postgres
DB_PASSWORD=yourpassword
DB_APP=postgres
```