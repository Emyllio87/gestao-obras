package com.gestaoobras.model.entity;

import com.gestaoobras.model.enums.TipoVinculo;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "funcionario", indexes = {
    @Index(name = "idx_funcionario_cpf", columnList = "cpf"),
    @Index(name = "idx_funcionario_nome", columnList = "nome"),
    @Index(name = "idx_funcionario_ativo", columnList = "ativo"),
    @Index(name = "idx_funcionario_obra_atual", columnList = "obra_atual_id"),
    @Index(name = "idx_funcionario_funcao", columnList = "funcao")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Funcionario {

    @Id
    @GeneratedValue
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "nome", nullable = false, length = 200)
    private String nome;

    @Column(name = "cpf", nullable = false, unique = true, length = 14)
    private String cpf;

    @Column(name = "rg", length = 20)
    private String rg;

    @Column(name = "telefone", length = 20)
    private String telefone;

    @Column(name = "endereco", length = 500)
    private String endereco;

    @Column(name = "funcao", length = 100)
    private String funcao;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_vinculo", nullable = false)
    private TipoVinculo tipoVinculo = TipoVinculo.DIARISTA;

    @Column(name = "valor_diaria", precision = 15, scale = 2, nullable = false)
    private BigDecimal valorDiaria = BigDecimal.ZERO;

    @Column(name = "dados_bancarios", length = 500)
    private String dadosBancarios;

    @Column(name = "pix", length = 200)
    private String pix;

    @Column(name = "data_admissao")
    private LocalDate dataAdmissao;

    @Column(name = "ativo", nullable = false)
    private Boolean ativo = true;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "obra_atual_id")
    private Obra obraAtual;

    @CreationTimestamp
    @Column(name = "criado_em", nullable = false, updatable = false)
    private LocalDateTime criadoEm;

    @UpdateTimestamp
    @Column(name = "atualizado_em", nullable = false)
    private LocalDateTime atualizadoEm;

    @Column(name = "criado_por")
    private UUID criadoPor;
}