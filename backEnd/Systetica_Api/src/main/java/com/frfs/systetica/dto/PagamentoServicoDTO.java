package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.frfs.systetica.entity.Servico;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PagamentoServicoDTO implements Serializable {

    @JsonProperty("id_pagamento_servico")
    private PagamentoServicoPKDTO idPagamentoServico;

    @JsonProperty("valor")
    private Double valor;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("pagamento")
    private PagamentoDTO pagamento;

    @JsonProperty("servicos")
    private List<Servico> servicos;
}