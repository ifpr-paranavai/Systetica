package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Usuario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Optional<Usuario> findByEmail(String email);

    Optional<Usuario> findByEmailAndCodigoAleatorio(String email, Integer codigo);

    @Query("""
            SELECT u FROM Usuario u WHERE 
                upper(u.nome) like upper(CONCAT('%',:search,'%')) 
                or upper(u.email) like upper(CONCAT('%',:search,'%'))
            """)
    Page<Usuario> findAllFields(@Param("search") String search, Pageable page);
}
