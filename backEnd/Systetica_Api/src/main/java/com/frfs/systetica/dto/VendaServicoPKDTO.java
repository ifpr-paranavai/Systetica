package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
@JsonInclude(JsonInclude.Include.NON_NULL)
public class VendaServicoPKDTO implements Serializable {

    @JsonProperty("venda_DTO")
    private VendaDTO vendaDTO;

    @JsonProperty("servico_DTO")
    private ServicoDTO servicoDTO;
}