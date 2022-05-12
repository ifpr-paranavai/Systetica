package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;

public interface UsuarioService {
    ReturnData<String> salvarUsuario(UsuarioDTO usuarioDTO);

    ReturnData<Object> buscarUsuario(Long id);

    ReturnData<Object> buscarUsuarioPorEmail(String email);

    ReturnData<Object> buscarTodosUsuario();
}
