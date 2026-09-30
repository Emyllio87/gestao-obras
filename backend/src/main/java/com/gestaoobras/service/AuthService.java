package com.gestaoobras.service;

import com.gestaoobras.dto.request.LoginRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {

    public Object autenticar(LoginRequest req) {
        log.info("Autenticação solicitada: {}", req.getEmail());
        // JWT + validação completa na próxima sprint — stub para escopo
        return new java.util.HashMap<String, String>() {{ put("token", "jwt-stub"); put("message", "AuthService — Fase 6 em progresso"); }};
    }
}