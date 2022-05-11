package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import org.springframework.data.domain.Pageable;

public interface CidadeService {

    ReturnData<Object> buscarTodasCidadesPaginado(String search, Pageable page);

    ReturnData<Object> buscarTodasCidades(Pageable page);
}
