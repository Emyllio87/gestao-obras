# Diagrama ER - Sistema de Gestão de Obras

```mermaid
erDiagram
    %% ===========================================
    %% CORE ENTITIES
    %% ===========================================
    USUARIO {
        uuid id PK
        varchar nome
        varchar email UK
        varchar senha
        perfil_usuario perfil
        boolean ativo
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    OBRA {
        uuid id PK
        varchar nome
        varchar endereco
        varchar cliente
        uuid responsavel_id FK
        date data_inicio
        date data_prevista_fim
        numeric orcamento_previsto
        status_obra status
        boolean ativo
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    FUNCIONARIO {
        uuid id PK
        varchar nome
        varchar cpf UK
        varchar rg
        varchar telefone
        varchar endereco
        varchar funcao
        tipo_vinculo tipo_vinculo
        numeric valor_diaria
        varchar dados_bancarios
        varchar pix
        date data_admissao
        boolean ativo
        uuid obra_atual_id FK
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    FORNECEDOR {
        uuid id PK
        varchar nome
        varchar cnpj UK
        varchar telefone
        varchar email
        varchar endereco
        boolean ativo
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    %% ===========================================
    %% OPERATIONAL ENTITIES
    %% ===========================================
    DIARIA {
        uuid id PK
        uuid funcionario_id FK
        uuid obra_id FK
        date data
        numeric quantidade
        numeric valor_unitario
        numeric valor_total COMPUTED
        varchar observacao
        status_diaria status
        uuid aprovado_por FK
        timestamp aprovado_em
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    PRESTACAO_CONTAS {
        uuid id PK
        uuid obra_id FK
        uuid responsavel_id FK
        date periodo_inicio
        date periodo_fim
        numeric valor_adiantado
        numeric total_despesas COMPUTED
        numeric saldo COMPUTED
        status_prestacao_contas status
        varchar observacao
        uuid aprovado_por FK
        timestamp aprovado_em
        varchar motivo_rejeicao
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    ITEM_PRESTACAO {
        uuid id PK
        uuid prestacao_id FK
        varchar descricao
        categoria_prestacao categoria
        date data
        numeric valor
        varchar numero_comprovante
        varchar anexo_url
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    REEMBOLSO {
        uuid id PK
        uuid solicitante_id FK
        uuid obra_id FK
        varchar descricao
        categoria_prestacao categoria
        date data_despesa
        numeric valor
        varchar comprovante_url
        status_reembolso status
        varchar motivo_rejeicao
        uuid aprovado_por FK
        timestamp aprovado_em
        date data_pagamento
        uuid pago_por FK
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    %% ===========================================
    %% MATERIAL & PAYMENT ENTITIES
    %% ===========================================
    PEDIDO_MATERIAL {
        uuid id PK
        uuid obra_id FK
        uuid solicitante_id FK
        date data_pedido
        date data_necessaria
        prioridade_pedido prioridade
        status_pedido_material status
        uuid fornecedor_id FK
        varchar observacao
        uuid aprovado_por FK
        timestamp aprovado_em
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    ITEM_PEDIDO_MATERIAL {
        uuid id PK
        uuid pedido_id FK
        varchar material
        unidade_medida unidade
        numeric quantidade
        numeric valor_estimado
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    ORDEM_PAGAMENTO {
        uuid id PK
        bigint numero UK
        uuid obra_id FK
        uuid favorecido_funcionario_id FK
        uuid favorecido_fornecedor_id FK
        origem_ordem_pagamento origem
        uuid origem_id
        numeric valor
        forma_pagamento forma_pagamento
        date data_emissao
        date data_vencimento
        date data_pagamento
        status_ordem_pagamento status
        varchar observacao
        uuid autorizado_por FK
        timestamp autorizado_em
        uuid pago_por FK
        timestamp criado_em
        timestamp atualizado_em
        uuid criado_por FK
    }

    %% ===========================================
    %% RELATIONSHIPS
    %% ===========================================
    USUARIO ||--o{ OBRA : "responsavel"
    USUARIO ||--o{ DIARIA : "aprovado_por"
    USUARIO ||--o{ PRESTACAO_CONTAS : "aprovado_por"
    USUARIO ||--o{ REEMBOLSO : "aprovado_por"
    USUARIO ||--o{ PEDIDO_MATERIAL : "aprovado_por"
    USUARIO ||--o{ ORDEM_PAGAMENTO : "autorizado_por"
    USUARIO ||--o{ ORDEM_PAGAMENTO : "pago_por"

    OBRA ||--o{ FUNCIONARIO : "obra_atual"
    OBRA ||--o{ DIARIA : "diarias"
    OBRA ||--o{ PRESTACAO_CONTAS : "prestacoes"
    OBRA ||--o{ REEMBOLSO : "reembolsos"
    OBRA ||--o{ PEDIDO_MATERIAL : "pedidos"
    OBRA ||--o{ ORDEM_PAGAMENTO : "ordens"

    FUNCIONARIO ||--o{ DIARIA : "diarias"
    FUNCIONARIO ||--o{ PRESTACAO_CONTAS : "responsavel"
    FUNCIONARIO ||--o{ REEMBOLSO : "solicitante"
    FUNCIONARIO ||--o{ PEDIDO_MATERIAL : "solicitante"
    FUNCIONARIO ||--o{ ORDEM_PAGAMENTO : "favorecido_funcionario"

    FORNECEDOR ||--o{ PEDIDO_MATERIAL : "fornecedor"
    FORNECEDOR ||--o{ ORDEM_PAGAMENTO : "favorecido_fornecedor"

    PRESTACAO_CONTAS ||--o{ ITEM_PRESTACAO : "itens"
    PEDIDO_MATERIAL ||--o{ ITEM_PEDIDO_MATERIAL : "itens"

    %% ===========================================
    %% ENUMS (documentação)
    %% ===========================================
    %% perfil_usuario: ADMIN, GESTOR, FINANCEIRO, ENCARREGADO
    %% status_obra: PLANEJADA, EM_ANDAMENTO, PAUSADA, CONCLUIDA
    %% tipo_vinculo: CLT, DIARISTA, EMPREITEIRO
    %% status_diaria: PENDENTE, APROVADA, PAGA
    %% status_prestacao_contas: ABERTA, ENVIADA, APROVADA, REJEITADA
    %% categoria_prestacao: MATERIAL, TRANSPORTE, ALIMENTACAO, FERRAMENTA, OUTROS
    %% status_reembolso: SOLICITADO, APROVADO, REJEITADO, PAGO
    %% prioridade_pedido: BAIXA, MEDIA, ALTA, URGENTE
    %% status_pedido_material: RASCUNHO, SOLICITADO, APROVADO, COMPRADO, ENTREGUE, CANCELADO
    %% forma_pagamento: PIX, TED, DINHEIRO, CHEQUE
    %% status_ordem_pagamento: EMITIDA, AUTORIZADA, PAGA, CANCELADA
    %% origem_ordem_pagamento: DIARIAS, REEMBOLSO, PEDIDO_MATERIAL, PRESTACAO_CONTAS, AVULSA
    %% unidade_medida: UN, KG, M, M2, M3, SC, L
```

---

## Índices Principais

| Tabela | Índices |
|--------|---------|
| usuario | email (UK), ativo |
| obra | status, ativo, responsavel_id |
| funcionario | cpf (UK), nome, ativo, obra_atual_id, funcao |
| fornecedor | nome, cnpj (UK), ativo |
| diaria | funcionario_id, obra_id, data, status, (funcionario_id, data, obra_id UK) |
| prestacao_contas | obra_id, responsavel_id, status, periodo |
| item_prestacao | prestacao_id, categoria, data |
| reembolso | solicitante_id, obra_id, status, data_despesa |
| pedido_material | obra_id, solicitante_id, status, prioridade, fornecedor_id |
| item_pedido_material | pedido_id |
| ordem_pagamento | numero (UK), obra_id, status, origem+origem_id, favorecido_func/forn, data_emissao |

---

## Constraints de Negócio

1. **Diaria**: Unique constraint em `(funcionario_id, obra_id, data)` - impede lançamento duplicado
2. **OrdemPagamento**: Check constraint garante que tem XOR favorecido_funcionario_id OU favorecido_fornecedor_id
3. **Valores monetários**: `NUMERIC(15,2)` / `BigDecimal` - precisão para centavos
4. **Quantidade diária**: `CHECK (quantidade > 0 AND quantidade <= 2)` - max 2 diarias/dia
5. **Valores positivos**: `CHECK (valor > 0)` em campos monetários
6. **Soft delete**: Campo `ativo` em todas entidades principais
7. **Auditoria**: `criado_em`, `atualizado_em`, `criado_por` em todas tabelas
8. **Trigger**: `atualizar_atualizado_em()` atualiza timestamp em UPDATE