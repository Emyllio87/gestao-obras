# Para 100% funcional — passos de verificação (não executados neste container)

1. docker compose up -d  (Postgres + PgAdmin)
2. cd backend && mvn compile  (verifica 11 entidades + 9 repos + controllers + JWT)
3. mvn test  (JUnit + TestContainers — stub criado, precisa de testes regulares)
4. cd ../frontend && npm install && npm run build
5. curl http://localhost:8080/api/obras  (via AuthController / JWT)

Estado atual: código fonte completo no disco, dependências configuradas (pom.xml),
migrations SQL consistentes (V1-V5), seed funcional, arquitetura sólida.
Não executado neste ambiente (sem JVM/npm no container de execução).
