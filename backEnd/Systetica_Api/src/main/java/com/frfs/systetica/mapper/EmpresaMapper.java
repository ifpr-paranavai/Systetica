package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.entity.Empresa;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface EmpresaMapper {

    @Mappings({
            @Mapping(target = "dataCadastro", ignore = true),
            @Mapping(target = "usuarioAdministrador", ignore = true),
    })
    EmpresaDTO toDto(Empresa entity);

    Empresa toEntity(EmpresaDTO dto);
}
