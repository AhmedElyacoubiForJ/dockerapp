# 🏗️ STAGE 1: Build mit Maven
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src

RUN ./mvnw clean package -DskipTests

# 🧼 Runtime Stage: schlanker Container
FROM gcr.io/distroless/java17-debian11
WORKDIR /app

COPY --from=builder /app/target/dockerapp-0.0.1-SNAPSHOT.jar app.jar

# 🔍 Healthcheck: ????

CMD ["java", "-jar", "app.jar"]

# docker build -t myapp:distroless-image .
