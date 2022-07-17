package com.frfs.systetica.mapper;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.entity.Usuario;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE, uses = EstadoMapper.class)
public interface UsuarioMapper {

    // DTO
    UsuarioDTO toDto(Usuario entity);

    List<UsuarioDTO> toListDto(List<Usuario> usuarios);

    // ENTITY
    Usuario toEntity(UsuarioDTO dto);
}
