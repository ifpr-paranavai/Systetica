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
    List<AgendarServico> findByDataAgendamentoOrderByHorarioAgendamento(String dataAgendamento);

    Optional<AgendarServico> findByDataAgendamentoAndHorarioAgendamento(String dataAgendamento,
                                                                        LocalTime horarioAgendamento);

    List<AgendarServico> findByDataAgendamentoAndClienteOrderByHorarioAgendamento(String dataAgendamento,
                                                                                  Usuario cliente);

    List<AgendarServico> findByDataAgendamentoAndFuncionarioOrderByHorarioAgendamento(String dataAgendamento,
                                                                                      Usuario funcionario);
}
