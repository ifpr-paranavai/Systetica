package com.frfs.systetica.repository;

import com.frfs.systetica.entity.FuncionarioServico;
import com.frfs.systetica.entity.FuncionarioServicoPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FuncionarioServicoRepository extends JpaRepository<FuncionarioServico, FuncionarioServicoPK> {
}
