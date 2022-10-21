package com.frfs.systetica.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DadosAgendamentoDTO implements Serializable {

    @JsonProperty("cliente_email")
    private String clienteEmail;

    @JsonProperty("funcionario_id")
    private Long funcionarioId;

    @JsonProperty("empresa_id")
    private Long empresaId;

    @JsonProperty("horario_agendamento")
    private HorarioAgendamentoDTO horarioAgendamento;

    @JsonProperty("servicos_selecionados")
    private List<ServicoDTO> servicosSelecionados;

    @JsonProperty("nome_cliente")
    private String nomeCliente;
}