package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.CidadeDTO;
import com.frfs.systetica.entity.Cidade;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface CidadeMapper {

    CidadeDTO toDto(Cidade entity);

    List<CidadeDTO> toListDto(List<Cidade> entities);

    Cidade toEntity(CidadeDTO dto);
}
