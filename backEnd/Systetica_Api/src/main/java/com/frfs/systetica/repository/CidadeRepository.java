package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Cidade;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CidadeRepository extends JpaRepository<Cidade, Long> {

    @Query(" SELECT u FROM Cidade u WHERE upper(u.nome) like upper(CONCAT('%',:search,'%'))")
    Page<Cidade> findAllFields(@Param("search") String search, Pageable page);

    Page<Cidade> findAll(Pageable page);

}
