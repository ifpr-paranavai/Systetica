package com.frfs.systetica.repository;

import com.frfs.systetica.entity.AgendarServico;
import com.frfs.systetica.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface AgendarServicoRepository extends JpaRepository<AgendarServico, Long> {
    List<AgendarServico> findByDataAgendamento(String dataAgendamento);

    Optional<AgendarServico> findByDataAgendamentoAndHorarioAgendamento(String dataAgendamento,
                                                                        LocalTime horarioAgendamento);

    List<AgendarServico> findByDataAgendamentoAndCliente(String dataAgendamento, Usuario cliente);
}
