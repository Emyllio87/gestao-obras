package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.CategoriaPrestacao;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "item_prestacao", indexes = {
    @Index(name = "idx_item_prestacao_prestacao", columnList = "prestacao_id"),
    @Index(name = "idx_item_prestacao_categoria", columnList = "categoria"),
    @Index(name = "idx_item_prestacao_data", columnList = "data")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ItemPrestacao {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prestacao_id", nullable = false)
    private PrestacaoContas prestacao;

    @Column(name = "descricao", nullable = false, length = 500)
    private String descricao;

    @Enumerated(EnumType.STRING)
    @Column(name = "categoria", nullable = false)
    private CategoriaPrestacao categoria;

    @Column(name = "data", nullable = false)
    private LocalDate data;

    @Column(name = "valor", precision = 15, scale = 2, nullable = false)
    private BigDecimal valor;

    @Column(name = "numero_comprovante", length = 100)
    private String numeroComprovante;

    @Column(name = "anexo_url", length = 500)
    private String anexoUrl;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Column(name = "criado_por")
    private UUID criadoPor;
}