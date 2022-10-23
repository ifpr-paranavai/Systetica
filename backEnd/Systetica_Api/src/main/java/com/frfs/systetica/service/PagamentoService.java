package com.frfs.systetica.service;

import com.frfs.systetica.dto.PagamentoProdutoDTO;
import com.frfs.systetica.dto.PagamentoServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;

public interface PagamentoService {
    ReturnData<String> pagamentoServico(PagamentoServicoDTO pagamentoServicoDTO);

    ReturnData<String> pagamentoProduto(PagamentoProdutoDTO pagamentoProdutoDTO);
}
