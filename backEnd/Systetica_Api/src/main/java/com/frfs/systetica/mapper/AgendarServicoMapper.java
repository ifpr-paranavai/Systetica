package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.AgendarServicoDTO;
import com.frfs.systetica.entity.AgendarServico;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface AgendarServicoMapper {


    @Mappings({
            @Mapping(target = "dataCadastro", ignore = true),
    })
    AgendarServicoDTO toDto(AgendarServico entity);

    List<AgendarServicoDTO> toListDto(List<AgendarServico> entities);

    AgendarServico toEntity(AgendarServicoDTO dto);
}
