package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.entity.Servico;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface ServicoMapper {

    @Mappings({
            @Mapping(target = "empresa", ignore = true),
    })
    ServicoDTO toDto(Servico entity);

    List<ServicoDTO> toListDto(List<Servico> entities);

    Servico toEntity(ServicoDTO dto);

    List<Servico> toListEntity(List<ServicoDTO> dtos);
}
