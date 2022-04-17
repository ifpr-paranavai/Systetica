package com.frfs.systetica.repository;

import com.frfs.systetica.entity.VendaPagamento;
import com.frfs.systetica.entity.VendaPagamentoPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VendaPagamentoRepository extends JpaRepository<VendaPagamento, VendaPagamentoPK> {
}
