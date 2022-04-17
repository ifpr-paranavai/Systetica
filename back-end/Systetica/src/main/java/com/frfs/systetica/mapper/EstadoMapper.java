package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.EstadoDTO;
import com.frfs.systetica.entity.Estado;
import org.mapstruct.Mapper;
import org.mapstruct.Named;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface EstadoMapper {

    // DTO
    EstadoDTO toDto(Estado entity);

    // ENTITY
    Estado toEntity(EstadoDTO dto);
}
