package edu.yacoubi.dockerapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class DbInfoController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/db-info")
    public Map<String, String> getDbInfo() {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT inet_server_addr() AS ip, current_database() AS db, current_user AS user",
                    (rs, rowNum) -> Map.of(
                            "ip", rs.getString("ip"),
                            "database", rs.getString("db"),
                            "user", rs.getString("user")
                    )
            );
        } catch (Exception e) {
            e.printStackTrace(); // Zeigt Fehler in der Konsole
            return Map.of("error", e.getMessage());
        }
    }

}

