package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.FormaPagamento;
import com.gestaoobras.model.enums.OrigemOrdemPagamento;
import com.gestaoobras.model.enums.StatusOrdemPagamento;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "ordem_pagamento", indexes = {
    @Index(name = "idx_ordem_pagamento_numero", columnList = "numero"),
    @Index(name = "idx_ordem_pagamento_obra", columnList = "obra_id"),
    @Index(name = "idx_ordem_pagamento_status", columnList = "status"),
    @Index(name = "idx_ordem_pagamento_origem", columnList = "origem, origem_id"),
    @Index(name = "idx_ordem_pagamento_favorecido_func", columnList = "favorecido_funcionario_id"),
    @Index(name = "idx_ordem_pagamento_favorecido_forn", columnList = "favorecido_fornecedor_id"),
    @Index(name = "idx_ordem_pagamento_data_emissao", columnList = "data_emissao")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrdemPagamento {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "numero", nullable = false, unique = true)
    private Long numero;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "obra_id", nullable = false)
    private Obra obra;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "favorecido_funcionario_id")
    private Funcionario favorecidoFuncionario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "favorecido_fornecedor_id")
    private Fornecedor favorecidoFornecedor;

    @Enumerated(EnumType.STRING)
    @Column(name = "origem", nullable = false)
    private OrigemOrdemPagamento origem;

    @Column(name = "origem_id", nullable = false)
    private UUID origemId;

    @Column(name = "valor", precision = 15, scale = 2, nullable = false)
    private BigDecimal valor;

    @Enumerated(EnumType.STRING)
    @Column(name = "forma_pagamento", nullable = false)
    private FormaPagamento formaPagamento = FormaPagamento.PIX;

    @Column(name = "data_emissao", nullable = false)
    private LocalDate dataEmissao = LocalDate.now();

    @Column(name = "data_vencimento")
    private LocalDate dataVencimento;

    @Column(name = "data_pagamento")
    private LocalDate dataPagamento;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private StatusOrdemPagamento status = StatusOrdemPagamento.EMITIDA;

    @Column(name = "observacao", length = 1000)
    private String observacao;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "autorizado_por")
    private Usuario autorizadoPor;

    @Column(name = "autorizado_em")
    private LocalDateTime autorizadoEm;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "pago_por")
    private Usuario pagoPor;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Column(name = "criado_por")
    private UUID criadoPor;
}