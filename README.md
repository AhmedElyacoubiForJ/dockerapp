Hier ist eine kompakte, gut strukturierte `README.md` – aus Sicht eines Entwicklers, mit klaren Schritten, deutschen Begriffen und ein paar passenden Emojis für Übersicht und Stil. 📘🐳

---

```markdown
# 🚀 Spring Boot + Docker – Mini-Projekt

Ein einfaches Beispielprojekt, das zeigt, wie man eine Spring Boot-Anwendung mit Docker betreibt.

## 📁 Projektstruktur

.
├── src/main/java/edu/yacoubi/dockerapp/DockerDemoApplication.java
├── pom.xml
└── Dockerfile
```

---

## 🧱 Bauplan: Dockerfile

```Dockerfile
FROM openjdk:17-jdk-slim
COPY target/dockerapp-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

---

## 🪜 Schritte zur Ausführung

### 1️⃣ Projekt bauen (JAR erzeugen)

```bash
mvn clean package
```

### 2️⃣ Docker-Image erstellen

```bash
docker build -t springboot-docker-demo .
```

### 3️⃣ Container starten

```bash
docker run -p 8080:8080 springboot-docker-demo
```

### 4️⃣ App im Browser öffnen

```
http://localhost:8080
```

---

## 🧹 Aufräumen (optional)

### Container stoppen

```bash
docker stop <container-id>
```

### Container löschen

```bash
docker rm <container-id>
```

### Image löschen

```bash
docker rmi springboot-docker-demo
```

---

## ✅ Ergebnis

Die Anwendung läuft im Docker-Container und ist über `localhost:8080/api/hello` erreichbar oder über
`curl http://localhost:8080/api/helllo`.
Ideal als Einstieg in die Containerisierung mit Spring Boot.


