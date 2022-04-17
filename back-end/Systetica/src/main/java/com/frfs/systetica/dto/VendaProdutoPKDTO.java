package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VendaProdutoPKDTO implements Serializable {

    @JsonProperty("venda_DTO")
    private VendaDTO vendaDTO;

    @JsonProperty("produto_DTO")
    private ProdutoDTO produtoDTO;
}