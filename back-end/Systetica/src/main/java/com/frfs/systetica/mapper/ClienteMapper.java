package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.ClienteDTO;
import com.frfs.systetica.entity.Cliente;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface ClienteMapper {

    // DTO
    ClienteDTO toDto(Cliente entity);

    // ENTITY
    Cliente toEntity(ClienteDTO dto);
}
