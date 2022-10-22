package com.frfs.systetica.service;

import com.frfs.systetica.dto.PagamentoServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;

public interface PagamentoService {
    ReturnData<String> pagamentoServico(PagamentoServicoDTO pagamentoServicoDTO);
}
