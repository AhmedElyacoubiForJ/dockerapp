# ────────────────────────────────────────────────────────────────
# 📦 Wann ist dieses Dockerfile relevant?
# → Immer dann, wenn die Anwendung als Container ausgeführt werden soll.
#   z.B. lokal, in der Cloud oder in CI/CD-Pipelines.

# 🔧 Was tut dieses Dockerfile?
# → Es erstellt ein schlankes Docker-Image aus dem kompilierten Java-JAR,
#   basierend auf dem offiziellen OpenJDK-Image.

# 🔄 Wie passt es in den Gesamt-Workflow?
# → Nach dem Bauen der App mit Maven (`mvn clean package`) wird dieses Dockerfile verwendet,
#   um ein ausführbares Image zu erzeugen.
#   Dieses Image kann dann mit `docker run` oder `docker compose` gestartet werden,
#   um die Anwendung bereitzustellen.

# ────────────────────────────────────────────────────────────────


# Nutze ein leichtes Java-Image
FROM openjdk:17-jdk-slim

# Kopiere das JAR ins Image
COPY target/dockerapp-0.0.1-SNAPSHOT.jar app.jar

# Starte die App
ENTRYPOINT ["java", "-jar", "/app.jar"]
