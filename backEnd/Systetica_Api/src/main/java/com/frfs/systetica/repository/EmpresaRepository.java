package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Empresa;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EmpresaRepository extends JpaRepository<Empresa, Long> {
    Optional<Empresa> findByCnpj(String cnpj);

    Optional<Empresa> findByUsuarioAdministradorEmail(String email);
}
