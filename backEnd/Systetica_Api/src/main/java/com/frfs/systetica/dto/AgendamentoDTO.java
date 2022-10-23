package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AgendamentoDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nome_cliente")
    private String nomeCliente;

    @JsonProperty("data_agendamento")
    private String dataAgendamento;

    @JsonProperty("horario_agendamento")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm")
    private LocalTime horarioAgendamento;

    @JsonProperty("data_cadastro")
    private Date dataCadastro;

    @JsonProperty("situacao")
    private SituacaoDTO situacao;

    @JsonProperty("cliente")
    private UsuarioDTO cliente;

    @JsonProperty("funcionario")
    private UsuarioDTO funcionario;

    @JsonProperty("empresa")
    private EmpresaDTO empresa;

    @JsonProperty("ass_servico_agendado")
    private List<ServicoDTO> servicos = new ArrayList<>();
}