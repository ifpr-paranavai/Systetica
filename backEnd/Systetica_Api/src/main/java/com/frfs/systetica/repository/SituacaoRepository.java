package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Situacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SituacaoRepository extends JpaRepository<Situacao, Long> {
    Optional<Situacao> findByNome(String nome);
}
