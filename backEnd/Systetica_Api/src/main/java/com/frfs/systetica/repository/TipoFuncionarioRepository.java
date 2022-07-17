package com.frfs.systetica.repository;

import com.frfs.systetica.entity.TipoFuncionario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TipoFuncionarioRepository extends JpaRepository<TipoFuncionario, Long> {
}
