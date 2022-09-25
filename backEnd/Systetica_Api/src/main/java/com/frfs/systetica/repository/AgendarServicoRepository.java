package com.frfs.systetica.repository;

import com.frfs.systetica.entity.AgendarServico;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AgendarServicoRepository extends JpaRepository<AgendarServico, Long> {
    List<AgendarServico> findByDataAgendamento(String dataAgendamento);
}
