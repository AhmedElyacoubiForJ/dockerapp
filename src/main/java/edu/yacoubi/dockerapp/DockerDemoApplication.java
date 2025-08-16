package edu.yacoubi.dockerapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@SpringBootApplication
@RestController
public class DockerDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DockerDemoApplication.class, args);
    }

    @GetMapping("/api/hello")
    public Map<String, String> hello() {
        return Map.of("message", "👋 Hello from Spring Boot, connected to PostgreSQL running in a Docker container!");
    }

}
