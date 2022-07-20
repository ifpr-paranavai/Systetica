package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.entity.Usuario;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface UsuarioMapper {

    @Mappings({
            @Mapping(target = "password", ignore = true),
    })
    UsuarioDTO toDto(Usuario entity);

    @Mappings({
            @Mapping(target = "password", ignore = true),
    })
    List<UsuarioDTO> toListDto(List<Usuario> usuarios);

    Usuario toEntity(UsuarioDTO dto);
}
