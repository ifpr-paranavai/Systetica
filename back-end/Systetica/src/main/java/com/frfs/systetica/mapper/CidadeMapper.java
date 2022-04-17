package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.CidadeDTO;
import com.frfs.systetica.entity.Cidade;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface CidadeMapper {

    // DTO
//    @Named(value = "toDto")
    CidadeDTO toDto(Cidade entity);

    // ENTITY
//    @Named(value = "toEntity")
    Cidade toEntity(CidadeDTO dto);
}
