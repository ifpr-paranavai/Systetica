package com.frfs.systetica.repository;

import com.frfs.systetica.entity.FormaPagamento;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FormaPagamentoRepository extends JpaRepository<FormaPagamento, Long> {

    @Query(" SELECT u FROM FormaPagamento u WHERE upper(u.nome) like upper(CONCAT('%',:search,'%'))")
    Page<FormaPagamento> findAllFields(@Param("search") String search, Pageable page);

    Page<FormaPagamento> findAll(Pageable page);
}
