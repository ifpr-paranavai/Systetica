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
public class FuncionarioServicoPKDTO implements Serializable {

    @JsonProperty("funcionario_DTO")
    private FuncionarioDTO funcionarioDTO;

    @JsonProperty("servico_DTO")
    private ServicoDTO servicoDTO;
}