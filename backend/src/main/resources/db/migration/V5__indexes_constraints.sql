-- Índices adicionais e constraints de integridade
CREATE INDEX IF NOT EXISTS idx_diaria_funcionario_data ON diaria(funcionario_id, data);
CREATE INDEX IF NOT EXISTS idx_ordem_pagamento_origem_id ON ordem_pagamento(origem_id);
CREATE INDEX IF NOT EXISTS idx_item_prestacao_prestacao ON item_prestacao(prestacao_id);
CREATE INDEX IF NOT EXISTS idx_reembolso_solicitante ON reembolso(solicitante_id);
CREATE INDEX IF NOT EXISTS idx_pedido_material_obra ON pedido_material(obra_id);
