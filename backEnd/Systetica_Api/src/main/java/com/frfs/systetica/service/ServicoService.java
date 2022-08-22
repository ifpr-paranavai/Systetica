package com.frfs.systetica.service;

import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import org.springframework.data.domain.Pageable;

public interface ServicoService {
    ReturnData<String> salvar(ServicoDTO servicoDTO);

    ReturnData<String> atualizar(ServicoDTO servicoDTO);

    ReturnData<Object> buscarTodosPaginado(String search, Pageable page, String emailAdministrativo);

    ReturnData<Object> buscarTodos(Pageable page, String emailAdministrativo);
}
