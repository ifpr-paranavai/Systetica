package com.frfs.systetica.service;

import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.mapper.RoleMapper;
import com.frfs.systetica.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;
    private final RoleMapper roleMapper;

    @Override
    public UsuarioDTO adicionarRoleUsuario(UsuarioDTO usuarioDTO, String roleName) {
        var roleDTO = roleMapper.toDto(roleRepository.findByName(roleName));
        List<RoleDTO> listRoleDto = new ArrayList<>();
        listRoleDto.add(roleDTO);
        usuarioDTO.setRoles(listRoleDto);
        return usuarioDTO;
    }
}