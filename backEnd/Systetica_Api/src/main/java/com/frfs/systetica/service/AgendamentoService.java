package com.frfs.systetica.service;

import com.frfs.systetica.dto.AgendamentoDTO;
import com.frfs.systetica.dto.DadosAgendamentoDTO;
import com.frfs.systetica.dto.response.ReturnData;


public interface AgendamentoService {
    ReturnData<Object> buscarTodosAgendamentoPorDia(String dia);

    ReturnData<Object> buscarTodosAgendamentoPorDiaUsuario(String dia, String email);

    ReturnData<String> salvar(DadosAgendamentoDTO dadosAgendamentoDTO);

    ReturnData<String> cancelar(AgendamentoDTO agendamentoDTO);

    ReturnData<Object> buscarTodosAgendamentoPorDiaAgendados(String dia);

    void alterarStatusAgendamento(AgendamentoDTO agendamentoDTO, String status);
}
