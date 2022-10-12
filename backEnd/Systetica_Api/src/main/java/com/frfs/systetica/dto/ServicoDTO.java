package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.frfs.systetica.entity.Empresa;
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
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ServicoDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nome")
    private String nome;

    @JsonProperty("tempo_servico")
    private Integer tempoServico;

    @JsonProperty("descricao")
    private String descricao;

    @JsonProperty("preco")
    private Double preco;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("status")
    private Boolean status;

    @JsonProperty("empresa")
    private EmpresaDTO empresa;

    @JsonProperty("agendar_servicos")
    private List<AgendarServicoDTO> agendarServicos = new ArrayList<>();

    @JsonProperty("email_administrativo")
    private String emailAdministrativo;
}