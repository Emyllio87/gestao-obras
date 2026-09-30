-- Flyway Migration V3: Create material and payment tables
-- PedidoMaterial, ItemPedidoMaterial, OrdemPagamento

-- ===========================================
-- TABELA: pedido_material
-- ===========================================
CREATE TABLE pedido_material (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    obra_id UUID NOT NULL REFERENCES obra(id),
    solicitante_id UUID NOT NULL REFERENCES funcionario(id),
    data_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
    data_necessaria DATE,
    prioridade prioridade_pedido NOT NULL DEFAULT 'MEDIA',
    status status_pedido_material NOT NULL DEFAULT 'RASCUNHO',
    fornecedor_id UUID REFERENCES fornecedor(id),
    observacao VARCHAR(1000),
    aprovado_por UUID REFERENCES usuario(id),
    aprovado_em TIMESTAMP,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_pedido_material_obra ON pedido_material(obra_id);
CREATE INDEX idx_pedido_material_solicitante ON pedido_material(solicitante_id);
CREATE INDEX idx_pedido_material_status ON pedido_material(status);
CREATE INDEX idx_pedido_material_prioridade ON pedido_material(prioridade);
CREATE INDEX idx_pedido_material_fornecedor ON pedido_material(fornecedor_id);

CREATE TRIGGER trg_pedido_material_atualizado
    BEFORE UPDATE ON pedido_material
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

-- ===========================================
-- TABELA: item_pedido_material
-- ===========================================
CREATE TABLE item_pedido_material (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    pedido_id UUID NOT NULL REFERENCES pedido_material(id) ON DELETE CASCADE,
    material VARCHAR(200) NOT NULL,
    unidade unidade_medida NOT NULL DEFAULT 'UN',
    quantidade NUMERIC(15,3) NOT NULL CHECK (quantidade > 0),
    valor_estimado NUMERIC(15,2) NOT NULL DEFAULT 0,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_item_pedido_material_pedido ON item_pedido_material(pedido_id);

CREATE TRIGGER trg_item_pedido_material_atualizado
    BEFORE UPDATE ON item_pedido_material
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

-- ===========================================
-- TABELA: ordem_pagamento
-- ===========================================
CREATE TABLE ordem_pagamento (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    numero BIGINT NOT NULL UNIQUE,
    obra_id UUID NOT NULL REFERENCES obra(id),
    favorecido_funcionario_id UUID REFERENCES funcionario(id),
    favorecido_fornecedor_id UUID REFERENCES fornecedor(id),
    origem origem_ordem_pagamento NOT NULL,
    origem_id UUID NOT NULL, -- ID da diaria, reembolso, pedido_material, prestacao_contas, ou NULL se AVULSA
    valor NUMERIC(15,2) NOT NULL CHECK (valor > 0),
    forma_pagamento forma_pagamento NOT NULL DEFAULT 'PIX',
    data_emissao DATE NOT NULL DEFAULT CURRENT_DATE,
    data_vencimento DATE,
    data_pagamento DATE,
    status status_ordem_pagamento NOT NULL DEFAULT 'EMITIDA',
    observacao VARCHAR(1000),
    autorizado_por UUID REFERENCES usuario(id),
    autorizado_em TIMESTAMP,
    pago_por UUID REFERENCES usuario(id),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID,
    CONSTRAINT chk_favorecido CHECK (
        (favorecido_funcionario_id IS NOT NULL AND favorecido_fornecedor_id IS NULL) OR
        (favorecido_funcionario_id IS NULL AND favorecido_fornecedor_id IS NOT NULL)
    )
);

CREATE INDEX idx_ordem_pagamento_numero ON ordem_pagamento(numero);
CREATE INDEX idx_ordem_pagamento_obra ON ordem_pagamento(obra_id);
CREATE INDEX idx_ordem_pagamento_status ON ordem_pagamento(status);
CREATE INDEX idx_ordem_pagamento_origem ON ordem_pagamento(origem, origem_id);
CREATE INDEX idx_ordem_pagamento_favorecido_func ON ordem_pagamento(favorecido_funcionario_id);
CREATE INDEX idx_ordem_pagamento_favorecido_forn ON ordem_pagamento(favorecido_fornecedor_id);
CREATE INDEX idx_ordem_pagamento_data_emissao ON ordem_pagamento(data_emissao);

CREATE TRIGGER trg_ordem_pagamento_atualizado
    BEFORE UPDATE ON ordem_pagamento
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

-- ===========================================
-- SEQUENCE para numero da ordem de pagamento
-- ===========================================
CREATE SEQUENCE IF NOT EXISTS seq_ordem_pagamento_numero START 1 INCREMENT 1;

-- Function to generate next numero
CREATE OR REPLACE FUNCTION next_ordem_pagamento_numero()
RETURNS BIGINT AS $$
DECLARE
    next_num BIGINT;
BEGIN
    SELECT nextval('seq_ordem_pagamento_numero') INTO next_num;
    RETURN next_num;
END;
$$ LANGUAGE plpgsql;