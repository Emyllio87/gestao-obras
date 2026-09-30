package com.gestaoobras.security;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class JwtUtil {
    @Value("${app.jwt.secret:gestao-obras-jwt-secret-key-2026}")
    private String secret;

    public SecretKey getKey() {
        return new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
    }

    public String generateToken(String email) {
        // Implementação JWT completa — Fase 6
        return "jwt-" + email + "-" + new Date().getTime();
    }
}