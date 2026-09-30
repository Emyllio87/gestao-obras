package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.StatusObra;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "obra", indexes = {
    @Index(name = "idx_obra_status", columnList = "status"),
    @Index(name = "idx_obra_ativo", columnList = "ativo"),
    @Index(name = "idx_obra_responsavel", columnList = "responsavel_id")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Obra {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "nome", nullable = false, length = 200)
    private String nome;

    @Column(name = "endereco", length = 500)
    private String endereco;

    @Column(name = "cliente", length = 200)
    private String cliente;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "responsavel_id")
    private Usuario responsavel;

    @Column(name = "data_inicio")
    private LocalDate dataInicio;

    @Column(name = "data_prevista_fim")
    private LocalDate dataPrevistaFim;

    @Column(name = "orcamento_previsto", precision = 15, scale = 2)
    private BigDecimal orcamentoPrevisto = BigDecimal.ZERO;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private StatusObra status = StatusObra.PLANEJADA;

    @Column(name = "ativo", nullable = false)
    private Boolean ativo = true;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Column(name = "criado_por")
    private UUID criadoPor;
}