package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.StatusDiaria;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "diaria", indexes = {
    @Index(name = "idx_diaria_funcionario", columnList = "funcionario_id"),
    @Index(name = "idx_diaria_obra", columnList = "obra_id"),
    @Index(name = "idx_diaria_data", columnList = "data"),
    @Index(name = "idx_diaria_status", columnList = "status"),
    @Index(name = "idx_diaria_funcionario_data_obra", columnList = "funcionario_id, data, obra_id")
},
uniqueConstraints = @UniqueConstraint(name = "uk_diaria_funcionario_obra_data", columnNames = {"funcionario_id", "obra_id", "data"}))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Diaria {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "funcionario_id", nullable = false)
    private Funcionario funcionario;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "obra_id", nullable = false)
    private Obra obra;

    @Column(name = "data", nullable = false)
    private LocalDate data;

    @Column(name = "quantidade", precision = 3, scale = 1, nullable = false)
    private BigDecimal quantidade = BigDecimal.ONE;

    @Column(name = "valor_unitario", precision = 15, scale = 2, nullable = false)
    private BigDecimal valorUnitario;

    @Column(name = "valor_total", precision = 15, scale = 2, insertable = false, updatable = false)
    private BigDecimal valorTotal;

    @Column(name = "observacao", length = 500)
    private String observacao;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private StatusDiaria status = StatusDiaria.PENDENTE;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "aprovado_por")
    private Usuario aprovadoPor;

    @Column(name = "aprovado_em")
    private LocalDateTime aprovadoEm;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Column(name = "criado_por")
    private UUID criadoPor;
}