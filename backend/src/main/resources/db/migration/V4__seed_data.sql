-- Flyway Migration V4: Seed data
-- Usuario ADMIN inicial (senha: admin123 - BCrypt hash)

-- Senha 'admin123' com BCrypt (cost 10)
-- $2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa

INSERT INTO usuario (id, nome, email, senha, perfil, ativo, criado_em, atualizado_em)
VALUES (
    '11111111-1111-1111-1111-111111111111',
    'Administrador do Sistema',
    'admin@gestaoobras.com',
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa',
    'ADMIN',
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Usuario GESTOR de teste
INSERT INTO usuario (id, nome, email, senha, perfil, ativo, criado_em, atualizado_em)
VALUES (
    '22222222-2222-2222-2222-222222222222',
    'Gestor de Obras',
    'gestor@gestaoobras.com',
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa',
    'GESTOR',
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Usuario FINANCEIRO de teste
INSERT INTO usuario (id, nome, email, senha, perfil, ativo, criado_em, atualizado_em)
VALUES (
    '33333333-3333-3333-3333-333333333333',
    'Financeiro',
    'financeiro@gestaoobras.com',
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa',
    'FINANCEIRO',
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Usuario ENCARREGADO de teste
INSERT INTO usuario (id, nome, email, senha, perfil, ativo, criado_em, atualizado_em)
VALUES (
    '44444444-4444-4444-4444-444444444444',
    'Encarregado de Obra',
    'encarregado@gestaoobras.com',
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa',
    'ENCARREGADO',
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Obra de exemplo
INSERT INTO obra (id, nome, endereco, cliente, responsavel_id, data_inicio, data_prevista_fim, orcamento_previsto, status, ativo, criado_em, atualizado_em)
VALUES (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Obra Residencial - Condominio Sol Nascente',
    'Rua das Flores, 123 - Bairro Jardim, Sao Paulo - SP',
    'Construtora Alpha Ltda',
    '22222222-2222-2222-2222-222222222222',
    '2024-01-15',
    '2024-12-20',
    2500000.00,
    'EM_ANDAMENTO',
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- Fornecedores de exemplo
INSERT INTO fornecedor (id, nome, cnpj, telefone, email, endereco, ativo, criado_em, atualizado_em)
VALUES
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Materiais de Construcao Sao Jose Ltda', '12.345.678/0001-90', '(11) 3333-4444', 'vendas@materiaisjose.com.br', 'Av. Industrial, 500 - Sao Paulo - SP', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Ferragens & Cia Comercio Ltda', '98.765.432/0001-10', '(11) 2222-1111', 'contato@ferragenscia.com.br', 'Rua do Ferro, 50 - Sao Paulo - SP', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Cimento Forte S/A', '11.222.333/0001-44', '(11) 4444-5555', 'comercial@cimentoforte.com.br', 'Rod. Anhanguera, Km 25 - Jundiai - SP', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Funcionarios de exemplo
INSERT INTO funcionario (id, nome, cpf, rg, telefone, endereco, funcao, tipo_vinculo, valor_diaria, dados_bancarios, pix, data_admissao, ativo, obra_atual_id, criado_em, atualizado_em)
VALUES
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Joao da Silva', '123.456.789-00', '12.345.678-9', '(11) 99999-1111', 'Rua A, 10 - Sao Paulo - SP', 'Pedreiro', 'CLT', 350.00, 'Banco do Brasil - Ag 1234 CC 56789-0', 'joao.silva@email.com', '2023-01-10', TRUE, 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Maria Santos', '987.654.321-00', '98.765.432-1', '(11) 98888-2222', 'Rua B, 20 - Sao Paulo - SP', 'Servente', 'DIARISTA', 200.00, 'Caixa - Ag 4321 CC 12345-6', 'maria.santos@email.com', '2023-03-15', TRUE, 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('gggggggg-gggg-gggg-gggg-gggggggggggg', 'Carlos Oliveira', '456.789.123-00', '45.678.912-3', '(11) 97777-3333', 'Rua C, 30 - Sao Paulo - SP', 'Eletricista', 'EMPREITEIRO', 450.00, 'Bradesco - Ag 5678 CC 98765-4', 'carlos.oliveira@email.com', '2023-06-01', TRUE, 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'Ana Costa', '789.123.456-00', '78.912.345-6', '(11) 96666-4444', 'Rua D, 40 - Sao Paulo - SP', 'Encarregada', 'CLT', 500.00, 'Itau - Ag 9012 CC 11111-2', 'ana.costa@email.com', '2022-11-20', TRUE, 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);