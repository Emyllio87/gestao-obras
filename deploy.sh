#!/usr/bin/env bash
# deploy.sh — Gestão de Obras
# Executar no VPS que hospeda o container (onde docker + java 17 + node estão)
set -euo pipefail

PROJECT_DIR="/data/.openclaw/workspace/projetos/gestao-obras"

echo "=== PASSO 1: Banco ==="
cd "$PROJECT_DIR" && docker compose up -d

echo "=== PASSO 2: Backend (Java 17 + Maven) ==="
cd "$PROJECT_DIR/backend"
mvn compile test
echo "Build backend OK"

echo "=== PASSO 3: Frontend (Node) ==="
cd "$PROJECT_DIR/frontend"
npm install
npm run build
echo "Build frontend OK (dist/ gerado)"

echo "=== PASSO 4: Subir aplicação ==="
cd "$PROJECT_DIR/backend"
nohup mvn spring-boot:run > ../logs/app.log 2>&1 &
sleep 3
echo "App iniciado (porta 8080)"

echo "=== PASSO 5: Provar ==="
curl -s -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@gestaoobras.com","senha":"admin123"}' | head -c 200

echo ""
echo "=== DEPLOY OK ==="
echo "Verifique: docker ps, mvn test, npm build, curl 8080/api/auth/login"
echo "Logs: $PROJECT_DIR/logs/app.log"
