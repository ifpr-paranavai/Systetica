package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.AgendamentoDTO;
import com.frfs.systetica.entity.Agendamento;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface AgendamentoMapper {


    @Mappings({
            @Mapping(target = "dataCadastro", ignore = true),
    })
    AgendamentoDTO toDto(Agendamento entity);

    List<AgendamentoDTO> toListDto(List<Agendamento> entities);

    Agendamento toEntity(AgendamentoDTO dto);
}
