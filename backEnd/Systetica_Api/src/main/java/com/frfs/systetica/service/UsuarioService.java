package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import org.springframework.data.domain.Pageable;

public interface UsuarioService {
    ReturnData<String> salvar(UsuarioDTO usuarioDTO);

    ReturnData<Object> buscarPorId(Long id);

    ReturnData<Object> buscarPorEmail(String email, boolean buscarParaToken);

    ReturnData<String> ativar(UsuarioDTO usuarioDTO);

    ReturnData<String> gerarCodigoAleatorio(String email);

    ReturnData<String> alterarSenha(UsuarioDTO usuarioDTO);

    ReturnData<String> atualizar(UsuarioDTO usuarioDTO);

    ReturnData<Object> buscarPorNomeEmail(String search, Pageable page);

    ReturnData<String> concederPermissaoFuncionairo(UsuarioDTO usuarioDTO);

    ReturnData<Object> buscarFuncionarios(String emailAdministrativo);

}
