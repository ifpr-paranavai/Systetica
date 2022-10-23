package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.PagamentoProdutoDTO;
import com.frfs.systetica.entity.PagamentoProduto;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface PagamentoProdutoMapper {

    PagamentoProdutoDTO toDto(PagamentoProduto entity);

    PagamentoProduto toEntity(PagamentoProdutoDTO dto);
}
