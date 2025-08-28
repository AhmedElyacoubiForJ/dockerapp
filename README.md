# 🧪 final-container-analysis

Dieses Projekt vergleicht verschiedene Docker-Images für eine einfache Java-Anwendung hinsichtlich ihrer Größe und potenziellen Sicherheit.

## 🔍 Ziel

Ziel ist es, verschiedene Container-Varianten zu analysieren und zu bewerten – mit Fokus auf:
- Image-Größe
- Basis-Image (z.B. Alpine, Distroless)
- Best Practices
- Sicherheit (in Vorbereitung)

## 📁 Struktur

- `Dockerfile.openjdk-slim`  
- `Dockerfile.eclipse-temurin`  
- `Dockerfile.eclipse-temurin-alpine`  
- `Dockerfile.distroless`  
- `Dockerfile.secure` *(noch leer – wird später ergänzt)*  
- `Dockerfile.bestpractices` *(basierend auf einem Artikel aus Medium)*  
- `scripts/compare-image-sizes.sh` – Skript zum Vergleich der Image-Größen

## 📊 Aktueller Vergleich

```bash
$ ./scripts/compare-image-sizes.sh
```

Ergebnisse:

| Image                        | Größe     |
|-----------------------------|-----------|
| openjdk-slim                | 413.53 MB |
| eclipse-temurin             | 275.18 MB |
| eclipse-temurin-alpine      | 199.52 MB |
| distroless                  | 240.22 MB |
| bestpractices               | 211.74 MB |
| secure-final                | ❌ nicht gefunden |

## 📋 Bewertung der Varianten

| Variante                   | ✅ Stärken                                                                 | ⚠️ Schwächen                                                           |
|----------------------------|---------------------------------------------------------------------------|------------------------------------------------------------------------|
| `openjdk-slim`            | - Vollständige Umgebung<br>- Gute Kompatibilität                          | - Sehr groß (413 MB)<br>- Enthält viele unnötige Komponenten          |
| `eclipse-temurin`         | - Offiziell gepflegt<br>- Solide Basis                                    | - Mittelgroß (275 MB)<br>- Keine spezielle Optimierung                |
| `eclipse-temurin-alpine`  | - Sehr klein (199 MB)<br>- Schneller Start                                 | - Alpine kann bei Debugging und Kompatibilität Probleme machen        |
| `distroless`              | - Keine Shell → weniger Angriffsfläche<br>- Fokus auf Sicherheit           | - Schwer zu debuggen<br>- Eingeschränkte Transparenz                  |
| `bestpractices`           | - Optimiert nach Community-Empfehlungen<br>- Gute Balance Größe/Sicherheit | - Komplexer Aufbau<br>- Weniger dokumentiert                          |
| `secure-final` *(geplant)*| - Fokus auf Sicherheit<br>- Minimale Angriffsfläche                        | - Noch nicht implementiert                                            |


> Diese Tabelle hilft uns später auch bei der Entscheidung, welche Variante sich für produktive Umgebungen am besten eignet. Später können wir noch Kriterien wie Startzeit, Layer-Struktur oder CVE-Scans ergänzen 🔐📦


## 🧾 Fazit

Die bisherigen Vergleiche zeigen deutlich, dass kleinere Basis-Images wie `eclipse-temurin-alpine` und `bestpractices` erheblich Speicherplatz sparen können, ohne die Funktionalität zu beeinträchtigen.  
Das größte Image (`openjdk-slim`) bietet zwar eine vertraute Umgebung, bringt aber unnötigen Overhead mit sich.  
`distroless` ist ein spannender Mittelweg zwischen Sicherheit und Größe, da es keine Shell enthält und potenzielle Angriffsflächen reduziert.  
Die Variante `secure-final` wird noch ergänzt und soll gezielt Sicherheitsaspekte wie minimale Angriffsfläche, Benutzerrechte und CVE-Scans berücksichtigen.

👉 Insgesamt zeigt sich: **Optimierung lohnt sich**, besonders wenn man gezielt auf schlanke und sichere Images setzt.

---

[//]: # (Wenn du magst, kann ich auch eine Bewertungstabelle mit Stärken/Schwächen je Variante ergänzen – oder später eine Empfehlung für produktive Umgebungen formulieren. Sag einfach Bescheid, wie tief du rein willst 🔍)

## 🛠️ Nächste Schritte

- `Dockerfile.secure` mit Fokus auf Sicherheitsaspekte ergänzen
- Analyse der Laufzeitumgebung und CVEs
- Dokumentation der Best Practices
