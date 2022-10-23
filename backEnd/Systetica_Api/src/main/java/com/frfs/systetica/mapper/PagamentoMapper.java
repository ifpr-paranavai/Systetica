package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.PagamentoDTO;
import com.frfs.systetica.entity.Pagamento;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface PagamentoMapper {

    PagamentoDTO toDto(Pagamento entity);

    Pagamento toEntity(PagamentoDTO dto);
}
