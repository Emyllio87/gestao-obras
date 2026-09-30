-- Flyway Migration V1: Create core tables
-- Usuario, Perfil enum, Obra, Funcionario, Fornecedor

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ===========================================
-- ENUMS (created as tables with check constraints for portability)
-- ===========================================

-- Perfil de usuario
CREATE TYPE perfil_usuario AS ENUM ('ADMIN', 'GESTOR', 'FINANCEIRO', 'ENCARREGADO');

-- Status de obra
CREATE TYPE status_obra AS ENUM ('PLANEJADA', 'EM_ANDAMENTO', 'PAUSADA', 'CONCLUIDA');

-- Tipo de vinculo funcionario
CREATE TYPE tipo_vinculo AS ENUM ('CLT', 'DIARISTA', 'EMPREITEIRO');

-- Status de diaria
CREATE TYPE status_diaria AS ENUM ('PENDENTE', 'APROVADA', 'PAGA');

-- Status de prestacao de contas
CREATE TYPE status_prestacao_contas AS ENUM ('ABERTA', 'ENVIADA', 'APROVADA', 'REJEITADA');

-- Categoria de item prestacao
CREATE TYPE categoria_prestacao AS ENUM ('MATERIAL', 'TRANSPORTE', 'ALIMENTACAO', 'FERRAMENTA', 'OUTROS');

-- Status de reembolso
CREATE TYPE status_reembolso AS ENUM ('SOLICITADO', 'APROVADO', 'REJEITADO', 'PAGO');

-- Prioridade de pedido material
CREATE TYPE prioridade_pedido AS ENUM ('BAIXA', 'MEDIA', 'ALTA', 'URGENTE');

-- Status de pedido material
CREATE TYPE status_pedido_material AS ENUM ('RASCUNHO', 'SOLICITADO', 'APROVADO', 'COMPRADO', 'ENTREGUE', 'CANCELADO');

-- Forma de pagamento
CREATE TYPE forma_pagamento AS ENUM ('PIX', 'TED', 'DINHEIRO', 'CHEQUE');

-- Status de ordem de pagamento
CREATE Type status_ordem_pagamento AS ENUM ('EMITIDA', 'AUTORIZADA', 'PAGA', 'CANCELADA');

-- Origem de ordem de pagamento
CREATE TYPE origem_ordem_pagamento AS ENUM ('DIARIAS', 'REEMBOLSO', 'PEDIDO_MATERIAL', 'PRESTACAO_CONTAS', 'AVULSA');

-- Unidade de medida
CREATE TYPE unidade_medida AS ENUM ('UN', 'KG', 'M', 'M2', 'M3', 'SC', 'L');

-- ===========================================
-- TABELA: usuario
-- ===========================================
CREATE TABLE usuario (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil perfil_usuario NOT NULL DEFAULT 'ENCARREGADO',
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_usuario_email ON usuario(email);
CREATE INDEX idx_usuario_ativo ON usuario(ativo);

-- ===========================================
-- TABELA: obra
-- ===========================================
CREATE TABLE obra (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome VARCHAR(200) NOT NULL,
    endereco VARCHAR(500),
    cliente VARCHAR(200),
    responsavel_id UUID REFERENCES usuario(id),
    data_inicio DATE,
    data_prevista_fim DATE,
    orcamento_previsto NUMERIC(15,2) DEFAULT 0,
    status status_obra NOT NULL DEFAULT 'PLANEJADA',
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_obra_status ON obra(status);
CREATE INDEX idx_obra_ativo ON obra(ativo);
CREATE INDEX idx_obra_responsavel ON obra(responsavel_id);

-- ===========================================
-- TABELA: funcionario
-- ===========================================
CREATE TABLE funcionario (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome VARCHAR(200) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    rg VARCHAR(20),
    telefone VARCHAR(20),
    endereco VARCHAR(500),
    funcao VARCHAR(100),
    tipo_vinculo tipo_vinculo NOT NULL DEFAULT 'DIARISTA',
    valor_diaria NUMERIC(15,2) NOT NULL DEFAULT 0,
    dados_bancarios VARCHAR(500),
    pix VARCHAR(200),
    data_admissao DATE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    obra_atual_id UUID REFERENCES obra(id),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_funcionario_cpf ON funcionario(cpf);
CREATE INDEX idx_funcionario_nome ON funcionario(nome);
CREATE INDEX idx_funcionario_ativo ON funcionario(ativo);
CREATE INDEX idx_funcionario_obra_atual ON funcionario(obra_atual_id);
CREATE INDEX idx_funcionario_funcao ON funcionario(funcao);

-- ===========================================
-- TABELA: fornecedor
-- ===========================================
CREATE TABLE fornecedor (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nome VARCHAR(200) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(200),
    endereco VARCHAR(500),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    criado_por UUID
);

CREATE INDEX idx_fornecedor_nome ON fornecedor(nome);
CREATE INDEX idx_fornecedor_cnpj ON fornecedor(cnpj);
CREATE INDEX idx_fornecedor_ativo ON fornecedor(ativo);

-- ===========================================
-- TRIGGER FUNCTION: atualizar_atualizado_em
-- ===========================================
CREATE OR REPLACE FUNCTION atualizar_atualizado_em()
RETURNS TRIGGER AS $$
BEGIN
    NEW.atualizado_em = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply trigger to all tables with atualizado_em
CREATE TRIGGER trg_usuario_atualizado
    BEFORE UPDATE ON usuario
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

CREATE TRIGGER trg_obra_atualizado
    BEFORE UPDATE ON obra
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

CREATE TRIGGER trg_funcionario_atualizado
    BEFORE UPDATE ON funcionario
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();

CREATE TRIGGER trg_fornecedor_atualizado
    BEFORE UPDATE ON fornecedor
    FOR EACH ROW EXECUTE FUNCTION atualizar_atualizado_em();