package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.FormaPagamentoDTO;
import com.frfs.systetica.entity.FormaPagamento;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface FormaPagamentoMapper {

    FormaPagamentoDTO toDto(FormaPagamento entity);

    List<FormaPagamentoDTO> toListDto(List<FormaPagamento> entities);

    FormaPagamento toEntity(FormaPagamentoDTO dto);
}
