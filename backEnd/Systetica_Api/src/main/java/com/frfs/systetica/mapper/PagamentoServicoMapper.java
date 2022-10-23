package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.PagamentoServicoDTO;
import com.frfs.systetica.entity.PagamentoServico;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface PagamentoServicoMapper {

    PagamentoServicoDTO toDto(PagamentoServico entity);

    PagamentoServico toEntity(PagamentoServicoDTO dto);
}
