package com.frfs.systetica.repository;

import com.frfs.systetica.entity.Agendamento;
import com.frfs.systetica.entity.Situacao;
import com.frfs.systetica.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {
    List<Agendamento> findByDataAgendamentoOrderByHorarioAgendamento(String dataAgendamento);

    Optional<Agendamento> findByDataAgendamentoAndHorarioAgendamento(String dataAgendamento,
                                                                     LocalTime horarioAgendamento);

    List<Agendamento> findByDataAgendamentoAndClienteOrderByHorarioAgendamento(String dataAgendamento,
                                                                               Usuario cliente);

    List<Agendamento> findByDataAgendamentoAndFuncionarioOrderByHorarioAgendamento(String dataAgendamento,
                                                                                   Usuario funcionario);

    List<Agendamento> findByDataAgendamentoAndSituacaoOrderByHorarioAgendamento(String dataAgendamento,
                                                                                Situacao situacao);
}
