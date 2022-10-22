package com.frfs.systetica.repository;

import com.frfs.systetica.entity.PagamentoProduto;
import com.frfs.systetica.entity.PagamentoProdutoPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PagamentoProdutoRepository extends JpaRepository<PagamentoProduto, PagamentoProdutoPK> {
}
