
> Alle relevanten `docker history` Befehle, damit du sie sauber festhalten kannst 🧾.

---

## 🧱 Docker History Befehle – kompakt zusammengefasst

### 🔍 Standard-Übersicht
```bash
docker history myimage:eclipse-temurin
```
Zeigt die Layer, Befehle, Größe und Kommentare – **gekürzt**.

---

### 📜 Vollständige Ausgabe (nicht abgeschnitten)
```bash
docker history myimage:eclipse-temurin --no-trunc
```
Zeigt **alle Details**, auch lange Befehle und Metadaten.

---

### 🔎 Nur bestimmte Layer filtern (z. B. RUN-Befehle)
```bash
docker history myimage:eclipse-temurin --no-trunc | grep 'RUN'
```

---

### 📁 Ausgabe in Datei speichern
```bash
docker history myimage:eclipse-temurin --no-trunc > history.txt
```
Ideal für spätere Analyse oder Versionskontrolle.

---

### 🧩 Nur relevante Felder anzeigen
```bash
docker history myimage:eclipse-temurin --format "{{.CreatedBy}} - {{.Size}}"
```
Zeigt nur den Befehl und die Größe jedes Layers.
