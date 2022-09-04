package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Cidade;
import com.frfs.systetica.entity.Empresa;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EmpresaRepository extends JpaRepository<Empresa, Long> {
    Optional<Empresa> findByCnpj(String cnpj);

    Optional<Empresa> findByUsuarioAdministradorEmail(String email);

    @Query(" SELECT u FROM Empresa u WHERE upper(u.nome) like upper(CONCAT('%',:search,'%'))")
    Page<Empresa> findAllFields(@Param("search") String search, Pageable page);
}
