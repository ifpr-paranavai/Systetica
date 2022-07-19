package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;

public interface UsuarioService {
    ReturnData<String> salvar(UsuarioDTO usuarioDTO);

    ReturnData<Object> buscarPorId(Long id);

    ReturnData<Object> buscarPorEmail(String email);

    ReturnData<Object> buscarTodos();

    ReturnData<String> ativarUsuario(UsuarioDTO usuarioDTO);

    ReturnData<String> gerarCodigo(UsuarioDTO usuarioDTO);

    ReturnData<String> alterarSenha(UsuarioDTO usuarioDTO);
}
