package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.ProdutoDTO;
import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.entity.Produto;
import com.frfs.systetica.entity.Servico;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface ProdutoMapper {

    @Mappings({
            @Mapping(target = "empresa", ignore = true),
    })
    ProdutoDTO toDto(Produto entity);

    List<ProdutoDTO> toListDto(List<Produto> entities);

    Produto toEntity(ProdutoDTO dto);
}
