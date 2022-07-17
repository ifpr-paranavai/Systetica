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
public class FuncionarioServicoDTO implements Serializable {

    @JsonProperty("funcionario_servico_PK_DTO")
    private FuncionarioServicoPKDTO funcionarioServicoPKDTO;

    @JsonProperty("valor_vnitario")
    private Double valorUnitario;

    @JsonProperty("total")
    private Double total;

    @JsonProperty("realiza_todos_servicos")
    private Boolean realizaTodosServicos;

    @JsonProperty("observacao")
    private String observacao;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("status")
    private String status = String.valueOf('A');
}