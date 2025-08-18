# 🐳 Dockerfile – Kontext und Zweck

## 📦 Wann ist dieses Dockerfile relevant?
> Dieses Dockerfile wird benötigt, wenn die Anwendung als Container ausgeführt werden soll. 
> z.B. lokal zur Entwicklung, in der Cloud zur Bereitstellung oder in CI/CD-Pipelines zur Automatisierung.

## 🔧 Was tut dieses Dockerfile?
> Es erstellt ein Docker-Image aus dem kompilierten Java-JAR.
> Dabei wird ein schlankes Base-Image (`openjdk:17-jdk-slim`) verwendet,
> um die Anwendung effizient und portabel bereitzustellen.
 
## 🐳 Dockerfile - code
> Erstellt ein schlankes Java-Image mit der App

```dockerfile
FROM openjdk:17-jdk-slim
COPY target/dockerapp-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

```

## 🔄 Wie passt es in den Gesamt-Workflow?
1. Die Anwendung wird mit Maven gebaut:

    ```bash
       mvn clean package
    ```
   
2. Das Dockerfile erzeugt daraus ein ausführbares Image:

    ```bash
       docker build -t dockerapp .
    ```
3. Die App kann dann gestartet werden:

    ```bash
       docker run -p 8080:8080 dockerapp

    ```

---

> Alternativ kann docker-compose verwendet werden, um mehrere Dienste (z.B. App + Datenbank) gemeinsam zu starten.
