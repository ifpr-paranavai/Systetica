package com.frfs.systetica.repository;

import com.frfs.systetica.entity.VendaServico;
import com.frfs.systetica.entity.VendaServicoPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VendaServicoRepository extends JpaRepository<VendaServico, VendaServicoPK> {
}
