package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;


public interface AgendarServicoService {
    ReturnData<Object> buscarTodosAgendamentoPorDia(String dia);
}
