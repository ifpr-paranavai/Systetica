package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Produto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProdutoRepository extends JpaRepository<Produto, Long> {

    @Query(""" 
                SELECT u FROM Produto u WHERE 
                    upper(u.nome) like upper(CONCAT('%',:search,'%'))
                    and upper(u.empresa.usuarioAdministrador.email) like upper(CONCAT('%',:emailAdministrador,'%'))
            """)
    Page<Produto> findAllFields(@Param("search") String search, Pageable page, String emailAdministrador);

    @Query(""" 
                SELECT u FROM Produto u WHERE 
                    upper(u.empresa.usuarioAdministrador.email) like upper(CONCAT('%',:emailAdministrador,'%'))
            """)
    Page<Produto> findAll(Pageable page, String emailAdministrador);

    List<Produto> findAllByEmpresaId(long id);
}
