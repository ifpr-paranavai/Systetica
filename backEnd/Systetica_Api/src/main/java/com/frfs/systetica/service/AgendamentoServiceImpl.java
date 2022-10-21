package com.frfs.systetica.service;

import com.frfs.systetica.dto.AgendamentoDTO;
import com.frfs.systetica.dto.DadosAgendamentoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.*;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.AgendamentoMapper;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.AgendamentoRepository;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.SituacaoRepository;
import com.frfs.systetica.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class AgendamentoServiceImpl implements AgendamentoService {

    private final AgendamentoRepository agendamentoRepository;
    private final UsuarioRepository usuarioRepository;
    private final EmpresaRepository empresaRepository;
    private final SituacaoRepository situacaoRepository;

    private final AgendamentoMapper agendamentoMapper;
    private final UsuarioMapper usuarioMapper;
    private final EmpresaMapper empresaMapper;

    @Override
    public ReturnData<Object> buscarTodosAgendamentoPorDia(String dataAgendamento) {
        List<String> listaDeHorarios = new ArrayList<>();
        List<Agendamento> agendamentos = agendamentoRepository
                .findByDataAgendamentoOrderByHorarioAgendamento(dataAgendamento);

        if (agendamentos.isEmpty()) {
            return new ReturnData<>(true, "", listaDeHorarios);
        }

        agendamentos.forEach(servico ->
                listaDeHorarios.add(servico.getHorarioAgendamento().toString())
        );

        return new ReturnData<>(true, "", listaDeHorarios);
    }

    @Override
    public ReturnData<Object> buscarTodosAgendamentoPorDiaUsuario(String dataAgendamento, String email) {
        Optional<Usuario> usuario = usuarioRepository.findByEmail(email);
        List<Agendamento> agendamentos;

        Role role = new Role();

        usuario.get().getRoles().forEach(element -> {
            role.setId(element.getId());
            role.setName(element.getName());
        });

        if (Objects.equals(role.getName(), "CLIENTE")) {
            agendamentos = agendamentoRepository
                    .findByDataAgendamentoAndClienteOrderByHorarioAgendamento(dataAgendamento, usuario.get());

        } else if (Objects.equals(role.getName(), "FUNCIONARIO")) {
            agendamentos = agendamentoRepository
                    .findByDataAgendamentoAndFuncionarioOrderByHorarioAgendamento(dataAgendamento, usuario.get());

        } else {
            agendamentos = agendamentoRepository
                    .findByDataAgendamentoOrderByHorarioAgendamento(dataAgendamento);
        }

        return new ReturnData<>(true, "", agendamentoMapper.toListDto(agendamentos));
    }

    @Override
    public ReturnData<String> salvar(DadosAgendamentoDTO dadosAgendamentoDTO) {
        try {
            Optional<Agendamento> agendarServicoBancoDeDados =
                    agendamentoRepository.findByDataAgendamentoAndHorarioAgendamento(
                            dadosAgendamentoDTO.getHorarioAgendamento().getDataAgendamento(),
                            dadosAgendamentoDTO.getHorarioAgendamento().getHorarioAgendamento());

            if (agendarServicoBancoDeDados.isEmpty()) {
                AgendamentoDTO agendamentoDTO = new AgendamentoDTO();
                if (dadosAgendamentoDTO.getClienteEmail() != null && !dadosAgendamentoDTO.getClienteEmail().isEmpty()) {
                    Optional<Usuario> cliente = usuarioRepository.findByEmail(dadosAgendamentoDTO.getClienteEmail());
                    agendamentoDTO.setCliente(usuarioMapper.toDto(cliente.get()));
                }

                Optional<Empresa> empresa = empresaRepository.findById(dadosAgendamentoDTO.getEmpresaId());
                Optional<Usuario> funcionario = usuarioRepository.findById(dadosAgendamentoDTO.getFuncionarioId());

                agendamentoDTO.setDataCadastro(new Date());
                agendamentoDTO.setDataAgendamento(dadosAgendamentoDTO.getHorarioAgendamento().getDataAgendamento());
                agendamentoDTO.setHorarioAgendamento(dadosAgendamentoDTO.getHorarioAgendamento().getHorarioAgendamento());
                agendamentoDTO.setServicos(dadosAgendamentoDTO.getServicosSelecionados());
                agendamentoDTO.setSituacao(situacaoRepository.findByName("AGENDADO").get());

                agendamentoDTO.setFuncionario(usuarioMapper.toDto(funcionario.get()));
                agendamentoDTO.setEmpresa(empresaMapper.toDto(empresa.get()));
                agendamentoDTO.setNomeCliente(dadosAgendamentoDTO.getNomeCliente());

                agendamentoRepository.saveAndFlush(agendamentoMapper.toEntity(agendamentoDTO));

                return new ReturnData<>(true, "Serviço agendado com sucesso.", "");
            }

            return new ReturnData<>(false, "Já foi agendado um serviço para o horário selecionado.",
                    "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um serviço", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um serviço",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> cancelar(AgendamentoDTO agendamentoDTO) {
        try {
            Optional<Agendamento> agendarServico = agendamentoRepository.findById(agendamentoDTO.getId());

            agendarServico.get().setSituacao(situacaoRepository.findByName("CANCELADO").get());

            agendamentoRepository.saveAndFlush(agendarServico.get());

            return new ReturnData<>(false, "Serviço cancelado com sucesso.", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao cancelar o serviço", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao cancelar o um serviço",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarTodosAgendamentoPorDiaAgendados(String dia) {
        Optional<Situacao> situacao = situacaoRepository.findByName("AGENDADO");

        List<Agendamento> agendamentos = agendamentoRepository
                .findByDataAgendamentoAndSituacaoOrderByHorarioAgendamento(dia, situacao.get());

        return new ReturnData<>(true, "", agendamentoMapper.toListDto(agendamentos));
    }
}
