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
public class AgendarServicoDTO implements Serializable {

    @JsonProperty("id")
    private Long id;

    @JsonProperty("nome")
    private String nome;

    @JsonProperty("data_agendamento_servico")
    private Date dataAgendamentoServico;

    @JsonProperty("data_finalizacao_servico")
    private Date dataFinalizacaoServico;

    @JsonProperty("data_cadastro_servico")
    private Date dataCadastroServico;

    @JsonProperty("situacao")
    private String situacao;

    @JsonProperty("observacao")
    private String observacao;

    @JsonProperty("status")
    private String status = String.valueOf('A');

    @JsonProperty("nome_cliente")
    private String nomeCliente;

    @JsonProperty("cliente_DTO")
    private ClienteDTO clienteDTO;

    @JsonProperty("funcionario_DTO")
    private FuncionarioDTO funcionarioDTO;

    @JsonProperty("servicos_DTO")
    private List<ServicoDTO> servicosDTO = new ArrayList<>();
}