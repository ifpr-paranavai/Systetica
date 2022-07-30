package com.frfs.systetica.service;

import com.frfs.systetica.dto.RoleDTO;

import java.util.Collection;

public interface RoleService {
    Collection<RoleDTO> buscaRolePorNome(String roleName);
}
