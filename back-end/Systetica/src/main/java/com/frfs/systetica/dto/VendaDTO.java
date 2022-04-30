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
public class VendaDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("total")
    private Double total;

    @JsonProperty("desconto")
    private Double desconto;

    @JsonProperty("observacao")
    private String observacao;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("status")
    private String status = String.valueOf('A');

    @JsonProperty("funcionario_DTO")
    private FuncionarioDTO funcionarioDTO;

    @JsonProperty("cliente_DTO")
    private UsuarioDTO usuarioDTO;
}