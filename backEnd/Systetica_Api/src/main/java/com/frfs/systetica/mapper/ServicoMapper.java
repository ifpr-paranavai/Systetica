package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.entity.Servico;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface ServicoMapper {

    ServicoDTO toDto(Servico entity);

    List<ServicoDTO> toListDto(List<Servico> entities);

    Servico toEntity(ServicoDTO dto);
}
