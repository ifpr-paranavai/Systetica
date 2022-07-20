package com.frfs.systetica.service;

import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.mapper.RoleMapper;
import com.frfs.systetica.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;

@Service
@RequiredArgsConstructor
@Slf4j
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;
    private final RoleMapper roleMapper;

    @Override
    public Collection<RoleDTO> buscaRolePorNome(String roleName) {
        Collection<RoleDTO> listRoleDto = new ArrayList<>();

        var roleDTO = roleMapper.toDto(roleRepository.findByName(roleName));

        listRoleDto.add(roleDTO);
        return listRoleDto;
    }
}
