package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;

public interface RoleService {
    UsuarioDTO adicionarRoleUsuario(UsuarioDTO usuarioDTO, String roleName);
}
