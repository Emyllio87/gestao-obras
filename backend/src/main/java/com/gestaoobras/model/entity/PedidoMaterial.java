package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.PrioridadePedido;
import com.gestaoobras.model.enums.StatusPedidoMaterial;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "pedido_material", indexes = {
    @Index(name = "idx_pedido_material_obra", columnList = "obra_id"),
    @Index(name = "idx_pedido_material_solicitante", columnList = "solicitante_id"),
    @Index(name = "idx_pedido_material_status", columnList = "status"),
    @Index(name = "idx_pedido_material_prioridade", columnList = "prioridade"),
    @Index(name = "idx_pedido_material_fornecedor", columnList = "fornecedor_id")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PedidoMaterial {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "obra_id", nullable = false)
    private Obra obra;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "solicitante_id", nullable = false)
    private Funcionario solicitante;

    @Column(name = "data_pedido", nullable = false)
    private LocalDate dataPedido = LocalDate.now();

    @Column(name = "data_necessaria")
    private LocalDate dataNecessaria;

    @Enumerated(EnumType.STRING)
    @Column(name = "prioridade", nullable = false)
    private PrioridadePedido prioridade = PrioridadePedido.MEDIA;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private StatusPedidoMaterial status = StatusPedidoMaterial.RASCUNHO;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fornecedor_id")
    private Fornecedor fornecedor;

    @Column(name = "observacao", length = 1000)
    private String observacao;

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