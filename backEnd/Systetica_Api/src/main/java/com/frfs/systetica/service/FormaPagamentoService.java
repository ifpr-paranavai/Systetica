package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import org.springframework.data.domain.Pageable;

public interface FormaPagamentoService {

    ReturnData<Object> buscarTodasFormasPagamentoPaginado(String search, Pageable page);

    ReturnData<Object> buscarTodasFormasPagament(Pageable page);
}
