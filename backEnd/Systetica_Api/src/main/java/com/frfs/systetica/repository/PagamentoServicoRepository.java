package com.frfs.systetica.repository;

import com.frfs.systetica.entity.PagamentoServico;
import com.frfs.systetica.entity.PagamentoServicoPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PagamentoServicoRepository extends JpaRepository<PagamentoServico, PagamentoServicoPK> {
}
