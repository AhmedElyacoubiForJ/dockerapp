# 🏗️ STAGE 1: Build mit Maven
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src

RUN ./mvnw clean package -DskipTests

# 🧼 Runtime Stage: schlanker Container
FROM eclipse-temurin:17-jre
WORKDIR /app

COPY --from=builder /app/target/dockerapp-0.0.1-SNAPSHOT.jar app.jar

# 🔍 Healthcheck: prüft alle 30s, ob Port 8080 antwortet
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

CMD ["java", "-jar", "app.jar"]
