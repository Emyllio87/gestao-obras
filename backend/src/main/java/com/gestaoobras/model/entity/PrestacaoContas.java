package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.StatusPrestacaoContas;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "prestacao_contas", indexes = {
    @Index(name = "idx_prestacao_obra", columnList = "obra_id"),
    @Index(name = "idx_prestacao_responsavel", columnList = "responsavel_id"),
    @Index(name = "idx_prestacao_status", columnList = "status"),
    @Index(name = "idx_prestacao_periodo", columnList = "periodo_inicio, periodo_fim")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PrestacaoContas {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "obra_id", nullable = false)
    private Obra obra;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "responsavel_id", nullable = false)
    private Funcionario responsavel;

    @Column(name = "periodo_inicio", nullable = false)
    private LocalDate periodoInicio;

    @Column(name = "periodo_fim", nullable = false)
    private LocalDate periodoFim;

    @Column(name = "valor_adiantado", precision = 15, scale = 2, nullable = false)
    private BigDecimal valorAdiantado = BigDecimal.ZERO;

    @Column(name = "total_despesas", precision = 15, scale = 2, insertable = false, updatable = false)
    private BigDecimal totalDespesas;

    @Column(name = "saldo", precision = 15, scale = 2, insertable = false, updatable = false)
    private BigDecimal saldo;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private StatusPrestacaoContas status = StatusPrestacaoContas.ABERTA;

    @Column(name = "observacao", length = 1000)
    private String observacao;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "aprovado_por")
    private Usuario aprovadoPor;

    @Column(name = "aprovado_em")
    private LocalDateTime aprovadoEm;

    @Column(name = "motivo_rejeicao", length = 500)
    private String motivoRejeicao;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Column(name = "criado_por")
    private UUID criadoPor;
}