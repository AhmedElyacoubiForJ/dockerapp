# Hinweis: Distroless hat kein Shell, kein Paketmanager, kein wget, kein bash.
# Nur Java und dein JAR. Super sicher, super schlank.

# STAGE 1: Build mit Maven
FROM maven:3.9.4-eclipse-temurin-17 AS builder
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

# STAGE 2: Distroless Runtime
FROM gcr.io/distroless/java17-debian11
COPY --from=builder /build/target/dockerapp-0.0.1-SNAPSHOT.jar /app.jar
CMD ["app.jar"]
