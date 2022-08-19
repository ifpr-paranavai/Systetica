package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ProdutoDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nome")
    private String nome;

    @JsonProperty("marca")
    private String marca;

    @JsonProperty("preco_compra")
    private Double precoCompra;

    @JsonProperty("preco_venda")
    private Double precoVenda;

    @JsonProperty("quant_estoque")
    private Integer quantEstoque;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("status")
    private Boolean status;

    @JsonProperty("empresa")
    private EmpresaDTO empresa;

    @JsonProperty("email_administrativo")
    private String emailAdministrativo;
}