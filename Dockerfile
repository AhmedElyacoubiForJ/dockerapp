# 🏗️ STAGE 1: Build mit Maven
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src

RUN ./mvnw clean package -DskipTests

# 🧼 Runtime Stage: schlanker
# STAGE 2: Alpine Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=builder /app/target/dockerapp-0.0.1-SNAPSHOT.jar app.jar

# 🔍 Optional: curl für Healthcheck
RUN apk add --no-cache curl

HEALTHCHECK CMD curl -f http://localhost:8080/actuator/health || exit 1

CMD ["java", "-jar", "app.jar"]

# docker build -t myapp:alpine-slim .

#🧪 Analyse deines slim-container Dockerfile
#✅ Positiv:
#Multi-Stage Build trennt sauber Build- und Runtime-Phase.
#
#Temurin-Images sind stabil und gut gepflegt.
#
#Healthcheck ist vorbildlich – viele vergessen das!
#
#Image-Größe mit 275 MB ist solide für ein Java-App-Setup.
#
#🔧 Optimierungsideen:
# Du könntest eclipse-temurin:17-jre durch temurin:17-jre-alpine ersetzen,
#   falls verfügbar – das spart nochmal Speicherplatz.
#
# Falls du keine .mvn/extensions.xml brauchst, könntest du .mvn/ gezielter kopieren.
#
# COPY src ./src kopiert alles – evtl. lohnt sich ein .dockerignore, um z.B. target/ oder IDE-Dateien auszuschließen.
