package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Servico;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ServicoRepository extends JpaRepository<Servico, Long> {

    @Query("""
            SELECT u FROM Servico u WHERE 
                upper(u.nome) like upper(CONCAT('%',:search,'%'))
                and upper(u.empresa.usuarioAdministrador.email) like upper(CONCAT('%',:emailAdministrador,'%'))
            """)
    Page<Servico> findAllFields(@Param("search") String search, Pageable page, String emailAdministrador);

    @Query(""" 
                SELECT u FROM Servico u WHERE 
                    upper(u.empresa.usuarioAdministrador.email) like upper(CONCAT('%',:emailAdministrador,'%'))
            """)
    Page<Servico> findAll(Pageable page, String emailAdministrador);
}
