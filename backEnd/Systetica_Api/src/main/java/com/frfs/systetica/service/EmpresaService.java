package com.frfs.systetica.service;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.response.ReturnData;
import org.springframework.data.domain.Pageable;

public interface EmpresaService {
    ReturnData<String> salvar(EmpresaDTO empresaDTO);

    ReturnData<String> atualizar(EmpresaDTO empresaDTO);

    ReturnData<Object> buscarPorEmailAdministrador(String email);

    ReturnData<Object> buscarTodasEmpresasPaginado(String search, Pageable page);

    ReturnData<Object> buscarTodasEmpresas(Pageable page);
}
