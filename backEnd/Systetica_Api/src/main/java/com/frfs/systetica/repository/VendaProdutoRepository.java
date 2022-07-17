package com.frfs.systetica.repository;

import com.frfs.systetica.entity.VendaProduto;
import com.frfs.systetica.entity.VendaProdutoPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VendaProdutoRepository extends JpaRepository<VendaProduto, VendaProdutoPK> {
}
