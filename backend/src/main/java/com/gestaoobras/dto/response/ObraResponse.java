package com.gestaoobras.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ObraResponse {
    private UUID id;
    private String nome;
    private String endereco;
    private String cliente;
    private UUID responsavelId;
    private String responsavelNome;
    private String dataInicio;
    private String dataPrevistaFim;
    private java.math.BigDecimal orcamentoPrevisto;
    private String status;
    private Boolean ativo;
    private LocalDateTime criadoEm;
    private LocalDateTime atualizadoEm;
}