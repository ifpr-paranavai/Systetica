package com.frfs.systetica.service;

import com.frfs.systetica.dto.ProdutoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import org.springframework.data.domain.Pageable;

public interface ProdutoService {
    ReturnData<String> salvar(ProdutoDTO produtoDTO);

    ReturnData<String> atualizar(ProdutoDTO produtoDTO);

    ReturnData<Object> buscarTodosPaginado(String search, Pageable page, String emailAdministrativo);

    ReturnData<Object> buscarTodos(Pageable page, String emailAdministrativo);

    ReturnData<Object> buscarTodosPorIdEmpresa(long id);
}
