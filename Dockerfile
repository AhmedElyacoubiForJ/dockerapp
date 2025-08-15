# Nutze ein leichtes Java-Image
FROM openjdk:17-jdk-slim

# Kopiere das JAR ins Image
COPY target/dockerapp-0.0.1-SNAPSHOT.jar app.jar

# Starte die App
ENTRYPOINT ["java", "-jar", "/app.jar"]
