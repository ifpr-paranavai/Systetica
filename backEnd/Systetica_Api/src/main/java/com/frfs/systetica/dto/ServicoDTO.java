package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ServicoDTO implements Serializable {

    @JsonProperty("name")
    private Long id;

    @JsonProperty("nome")
    private String nome;

    @JsonProperty("tempo_servico")
    private Integer tempoServico;

    @JsonProperty("tipo_servico")
    private String tipoServico;

    @JsonProperty("descricao")
    private String descricao;

    @JsonProperty("preco")
    private Double preco;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("status")
    private String status = String.valueOf('A');

    @JsonProperty("agendar_servicos_DTO")
    private List<AgendarServicoDTO> agendarServicosDTO = new ArrayList<>();
}