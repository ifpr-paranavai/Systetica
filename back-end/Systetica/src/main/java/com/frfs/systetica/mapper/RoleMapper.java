package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.entity.Role;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface RoleMapper {

    // DTO
    RoleDTO toDto(Role entity);

    // ENTITY
    Role toEntity(RoleDTO dto);
}