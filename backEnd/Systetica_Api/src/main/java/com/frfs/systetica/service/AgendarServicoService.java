package com.frfs.systetica.service;

import com.frfs.systetica.dto.AgendamentoDTO;
import com.frfs.systetica.dto.DadosAgendamentoDTO;
import com.frfs.systetica.dto.response.ReturnData;


public interface AgendarServicoService {
    ReturnData<Object> buscarTodosAgendamentoPorDia(String dia);

    ReturnData<Object> buscarTodosAgendamentoPorDiaUsuario(String dia, String email);

    ReturnData<String> salvar(DadosAgendamentoDTO dadosAgendamentoDTO);

    ReturnData<String> cancelar(AgendamentoDTO agendamentoDTO);
}
