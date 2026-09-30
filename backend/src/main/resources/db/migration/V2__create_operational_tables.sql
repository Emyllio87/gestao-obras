-- Flyway Migration V2: Create operational tables
-- Diaria, PrestacaoContas, ItemPrestacao, Reembolso, PedidoMaterial, ItemPedidoMaterial, OrdemPagamento

-- ===========================================
-- TABELA: diaria
-- ===========================================
CREATE TABLE diaria (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    funcionario_id UUID NOT NULL REFERENCES funcionario(id),
    obra_id UUID NOT NULL REFERENCES obra(id),
    data DATE NOT NULL,
    quantidade NUMERIC(3,1) NOT NULL DEFAULT 1 CHECK (quantidade > 0 AND quantidade <= 2),
    valor_unitario NUMERIC(15,2) NOT NULL,
    valor_total NUMERIC(15,2) GENERATED ALWAYS AS (quantidade * valor_unitario) STORED,
    observacao VARCHAR(500),
    status status_diaria NOT NULL DEFAULT 'PENDENTE',
    aprovado_por UUID REFERENCES usuario(id),
    aprovado_em TIMESTAMP,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID,
    UNIQUE (funcionario_id, obra_id, data)
);

CREATE INDEX idx_diaria_funcionario ON diaria(funcionario_id);
CREATE INDEX idx_diaria_obra ON diaria(obra_id);
CREATE INDEX idx_diaria_data ON diaria(data);
CREATE INDEX idx_diaria_status ON diaria(status);
CREATE INDEX idx_diaria_funcionario_data_obra ON diaria(funcionario_id, data, obra_id);

CREATE TRIGGER trg_diaria_atualizado
    BEFORE UPDATE ON diaria
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

-- ===========================================
-- TABELA: prestacao_contas
-- ===========================================
CREATE TABLE prestacao_contas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    obra_id UUID NOT NULL REFERENCES obra(id),
    responsavel_id UUID NOT NULL REFERENCES funcionario(id),
    periodo_inicio DATE NOT NULL,
    periodo_fim DATE NOT NULL,
    valor_adiantado NUMERIC(15,2) NOT NULL DEFAULT 0,
    total_despesas NUMERIC(15,2) GENERATED ALWAYS AS (
        (SELECT COALESCE(SUM(valor), 0) FROM item_prestacao WHERE prestacao_id = prestacao_contas.id)
    ) STORED,
    saldo NUMERIC(15,2) GENERATED ALWAYS AS (valor_adiantado - (
        SELECT COALESCE(SUM(valor), 0) FROM item_prestacao WHERE prestacao_id = prestacao_contas.id
    )) STORED,
    status status_prestacao_contas NOT NULL DEFAULT 'ABERTA',
    observacao VARCHAR(1000),
    aprovado_por UUID REFERENCES usuario(id),
    aprovado_em TIMESTAMP,
    motivo_rejeicao VARCHAR(500),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_prestacao_obra ON prestacao_contas(obra_id);
CREATE INDEX idx_prestacao_responsavel ON prestacao_contas(responsavel_id);
CREATE INDEX idx_prestacao_status ON prestacao_contas(status);
CREATE INDEX idx_prestacao_periodo ON prestacao_contas(periodo_inicio, periodo_fim);

CREATE TRIGGER trg_prestacao_contas_atualizado
    BEFORE UPDATE ON prestacao_contas
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

-- ===========================================
-- TABELA: item_prestacao
-- ===========================================
CREATE TABLE item_prestacao (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    prestacao_id UUID NOT NULL REFERENCES prestacao_contas(id) ON DELETE CASCADE,
    descricao VARCHAR(500) NOT NULL,
    categoria categoria_prestacao NOT NULL,
    data DATE NOT NULL,
    valor NUMERIC(15,2) NOT NULL CHECK (valor > 0),
    numero_comprovante VARCHAR(100),
    anexo_url VARCHAR(500),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_item_prestacao_prestacao ON item_prestacao(prestacao_id);
CREATE INDEX idx_item_prestacao_categoria ON item_prestacao(categoria);
CREATE INDEX idx_item_prestacao_data ON item_prestacao(data);

CREATE TRIGGER trg_item_prestacao_atualizado
    BEFORE UPDATE ON item_prestacao
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

-- ===========================================
-- TABELA: reembolso
-- ===========================================
CREATE TABLE reembolso (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    solicitante_id UUID NOT NULL REFERENCES funcionario(id),
    obra_id UUID NOT NULL REFERENCES obra(id),
    descricao VARCHAR(500) NOT NULL,
    categoria categoria_prestacao NOT NULL,
    data_despesa DATE NOT NULL,
    valor NUMERIC(15,2) NOT NULL CHECK (valor > 0),
    comprovante_url VARCHAR(500),
    status status_reembolso NOT NULL DEFAULT 'SOLICITADO',
    motivo_rejeicao VARCHAR(500),
    aprovado_por UUID REFERENCES usuario(id),
    aprovado_em TIMESTAMP,
    data_pagamento DATE,
    pago_por UUID REFERENCES usuario(id),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_reembolso_solicitante ON reembolso(solicitante_id);
CREATE INDEX idx_reembolso_obra ON reembolso(obra_id);
CREATE INDEX idx_reembolso_status ON reembolso(status);
CREATE INDEX idx_reembolso_data_despesa ON reembolso(data_despesa);

CREATE TRIGGER trg_reembolso_atualizado
    BEFORE UPDATE ON reembolso
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();