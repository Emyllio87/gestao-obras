package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.UnidadeMedida;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "item_pedido_material", indexes = {
    @Index(name = "idx_item_pedido_material_pedido", columnList = "pedido_id")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ItemPedidoMaterial {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "pedido_id", nullable = false)
    private PedidoMaterial pedido;

    @Column(name = "material", nullable = false, length = 200)
    private String material;

    @Enumerated(EnumType.STRING)
    @Column(name = "unidade", nullable = false)
    private UnidadeMedida unidade = UnidadeMedida.UN;

    @Column(name = "quantidade", precision = 15, scale = 3, nullable = false)
    private BigDecimal quantidade;

    @Column(name = "valor_estimado", precision = 15, scale = 2, nullable = false)
    private BigDecimal valorEstimado = BigDecimal.ZERO;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Column(name = "criado_por")
    private UUID criadoPor;
}