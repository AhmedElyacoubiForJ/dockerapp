# **Secure Container Blueprint** 🛡️  
> Vorlage oder Checkliste.

---

## 🧱 Secure Container Blueprint (Dockerfile + Runtime + Umgebung)

```Dockerfile
# 🔹 1. Verwende ein minimales, vertrauenswürdiges Base Image
FROM debian:bullseye-slim
# Alternativen: alpine, busybox, oder distroless (wenn du später wieder willst)

# 🔹 2. Setze einen nicht-root User
RUN useradd -r -u 1001 appuser
USER appuser

# 🔹 3. Setze das Dateisystem auf read-only
# (Wird beim Container-Start gesetzt, nicht im Dockerfile)
# Beispiel: docker run --read-only ...

# 🔹 4. Entferne unnötige Tools
RUN apt-get purge -y curl wget bash nano && apt-get clean

# 🔹 5. Setze Arbeitsverzeichnis
WORKDIR /app

# 🔹 6. Kopiere nur das Nötigste
COPY --chown=appuser:appuser ./app-binary /app/app-binary

# 🔹 7. Setze minimale Laufzeit-Umgebung
ENV TZ=UTC \
    LANG=C.UTF-8 \
    APP_ENV=production

# 🔹 8. Starte mit explizitem CMD
CMD ["/app/app-binary"]
```

---

## ⚙️ Runtime-Härtung (docker run Optionen)

```bash
docker run \
  --read-only \                         # 🔐 Dateisystem schreibgeschützt
  --cap-drop ALL \                      # 🚫 Alle Linux-Capabilities entfernen
  --security-opt no-new-privileges:true \  # 🛑 Keine Privilegien-Erweiterung
  --pids-limit 100 \                    # 🧠 Schutz vor Fork-Bomben
  --memory 128m --cpus 0.5 \            # ⚖️ Ressourcen begrenzen
  --user 1001 \                         # 👤 Nicht-root User
  --network bridge \                    # 🌐 Isoliertes Netzwerk
  --health-cmd "curl -f http://localhost:8080/health || exit 1" \
  --health-interval=30s \
  --health-retries=3 \
  my-secure-image
```

---

## 🔐 Secrets & Konfiguration

- **Secrets nicht als ENV**: Stattdessen über sichere Mechanismen wie:
    - Docker Secrets (`/run/secrets/...`)
    - HashiCorp Vault
    - Kubernetes Secrets mit RBAC
- **Konfigurationsdateien**:
    - Nur lesend mounten (`:ro`)
    - Keine `.env` im Image

---

## 🧪 Build & Supply Chain

- **Verwende SBOMs**: Software Bill of Materials (z. B. mit Syft)
- **Signiere Images**: Mit Cosign oder Notary v2
- **Scanne regelmäßig**:
    - Trivy, Grype, Snyk → CI/CD Integration
- **Vermeide `latest` Tags**: Immer mit festen Versionsnummern arbeiten

---

## 🛡️ OS-Level Schutz (optional)

- **AppArmor / Seccomp / SELinux**:
    - AppArmor-Profil: `--security-opt apparmor=your-profile`
    - Seccomp: `--security-opt seccomp=default.json`
- **Audit Logging**: z. B. mit Falco oder eBPF

---

## 📦 Beispielstruktur für dein Projekt

```
project/
├── Dockerfile.secure
├── app-binary
├── config/
│   └── app.conf
├── secrets/
│   └── db-password (nicht ins Image!)
└── README.md
```
