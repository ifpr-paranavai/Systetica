package com.frfs.systetica.service;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.response.ReturnData;

public interface EmpresaService {
    ReturnData<String> salvar(EmpresaDTO empresaDTO);

    ReturnData<String> atualizar(EmpresaDTO empresaDTO);

    ReturnData<Object> buscarPorEmailAdministrador(String email);
}
