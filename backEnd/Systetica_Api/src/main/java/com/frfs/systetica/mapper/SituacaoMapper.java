package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.SituacaoDTO;
import com.frfs.systetica.entity.Situacao;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface SituacaoMapper {

    SituacaoDTO toDto(Situacao entity);
}
