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
public class PagamentoDTO implements Serializable {

    @JsonProperty("name")
    private Long id;

    @JsonProperty("valor_total")
    private Double valorTotal;

    @JsonProperty("desconto")
    private Double desconto;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

}