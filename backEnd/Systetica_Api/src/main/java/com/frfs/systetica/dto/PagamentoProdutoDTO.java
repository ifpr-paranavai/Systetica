package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.frfs.systetica.entity.PagamentoProdutoPK;
import com.frfs.systetica.entity.Produto;
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
public class PagamentoProdutoDTO implements Serializable {

    @JsonProperty("id_pagamento_produto")
    private PagamentoProdutoPKDTO idPagamentoProduto;

    @JsonProperty("quantidade")
    private Integer quantidade;

    @JsonProperty("valor_unitario")
    private Double valorUnitario;

    @JsonProperty("valor_total")
    private Double valorTotal;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("pagamento")
    private PagamentoDTO pagamento;

    @JsonProperty("produtos")
    private List<ProdutoDTO> produtos;
}