package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VendaProdutoDTO implements Serializable {

    @JsonProperty("venda_produto_PK_DTO")
    private VendaProdutoPKDTO vendaProdutoPKDTO;

    @JsonProperty("quantidade")
    private Integer quantidade;

    @JsonProperty("valor_unitario")
    private Double valorUnitario;

    @JsonProperty("valor_total")
    private Double valorTotal;

    @JsonProperty("observacao")
    private String observacao;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;
}