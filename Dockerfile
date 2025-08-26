# s.h. https://medium.com/@rohitloke/spring-boot-docker-best-practices-4bf4fdec158
# Spring boot: Docker best practices
FROM maven:3.9.3-eclipse-temurin-17-alpine@sha256:1cbc71cb8e2f594338f4b4cbca897b9f9ed6183e361489f1f7db770d57efe839 AS builder
WORKDIR build
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY . .
RUN mvn clean install -DskipTests

FROM eclipse-temurin:17.0.6_10-jre-alpine@sha256:c26a727c4883eb73d32351be8bacb3e70f390c2c94f078dc493495ed93c60c2f AS layers
WORKDIR layer
COPY --from=builder /build/target/dockerapp-0.0.1-SNAPSHOT.jar app.jar
RUN java -Djarmode=layertools -jar app.jar extract

FROM eclipse-temurin:17.0.6_10-jre-alpine@sha256:c26a727c4883eb73d32351be8bacb3e70f390c2c94f078dc493495ed93c60c2f
WORKDIR /opt/app
RUN addgroup --system appuser && adduser -S -s /usr/sbin/nologin -G appuser appuser
COPY --from=layers /layer/dependencies/ ./
COPY --from=layers /layer/spring-boot-loader/ ./
COPY --from=layers /layer/snapshot-dependencies/ ./
COPY --from=layers /layer/application/ ./
RUN chown -R appuser:appuser /opt/app
USER appuser
HEALTHCHECK --interval=30s --timeout=3s --retries=1 CMD wget -qO- http://localhost:8080/actuator/health/ | grep UP || exit 1
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]












## 🏗️ STAGE 1: Build mit Maven
#FROM eclipse-temurin:17-jdk AS builder
#WORKDIR /app
#
#COPY .mvn/ .mvn
#COPY mvnw pom.xml ./
#COPY src ./src
#
#RUN ./mvnw clean package -DskipTests
#
## 🧼 Runtime Stage: schlanker Container
#FROM gcr.io/distroless/java17-debian11
#WORKDIR /app
#
#COPY --from=builder /app/target/dockerapp-0.0.1-SNAPSHOT.jar app.jar
#
## 🔍 Healthcheck: ????
#
#CMD ["java", "-jar", "app.jar"]
#
## docker build -t myapp:distroless-image .
