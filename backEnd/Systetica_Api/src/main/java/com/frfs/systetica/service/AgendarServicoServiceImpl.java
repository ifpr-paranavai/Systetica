package com.frfs.systetica.service;

import com.frfs.systetica.dto.AgendamentoDTO;
import com.frfs.systetica.dto.DadosAgendamentoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Agendamento;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.entity.Role;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.AgendarServicoMapper;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.ServicoMapper;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.AgendarServicoRepository;
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
public class AgendarServicoServiceImpl implements AgendarServicoService {

    private final AgendarServicoRepository agendarServicoRepository;
    private final UsuarioRepository usuarioRepository;
    private final EmpresaRepository empresaRepository;
    private final SituacaoRepository situacaoRepository;

    private final AgendarServicoMapper agendarServicoMapper;
    private final UsuarioMapper usuarioMapper;
    private final EmpresaMapper empresaMapper;
    private final ServicoMapper servicoMapper;

    @Override
    public ReturnData<Object> buscarTodosAgendamentoPorDia(String dataAgendamento) {
        List<String> listaDeHorarios = new ArrayList<>();
        List<Agendamento> servicosAgendados = agendarServicoRepository
                .findByDataAgendamentoOrderByHorarioAgendamento(dataAgendamento);

        if (servicosAgendados.isEmpty()) {
            return new ReturnData<>(true, "", listaDeHorarios);
        }

        servicosAgendados.forEach(servico ->
                listaDeHorarios.add(servico.getHorarioAgendamento().toString())
        );

        return new ReturnData<>(true, "", listaDeHorarios);
    }

    @Override
    public ReturnData<Object> buscarTodosAgendamentoPorDiaUsuario(String dataAgendamento, String email) {
        Optional<Usuario> usuario = usuarioRepository.findByEmail(email);
        List<Agendamento> servicosAgendados;

        Role role = new Role();

        usuario.get().getRoles().forEach(element -> {
            role.setId(element.getId());
            role.setName(element.getName());
        });

        if (Objects.equals(role.getName(), "CLIENTE")) {
            servicosAgendados = agendarServicoRepository
                    .findByDataAgendamentoAndClienteOrderByHorarioAgendamento(dataAgendamento, usuario.get());

        } else if (Objects.equals(role.getName(), "FUNCIONARIO")) {
            servicosAgendados = agendarServicoRepository
                    .findByDataAgendamentoAndFuncionarioOrderByHorarioAgendamento(dataAgendamento, usuario.get());

        } else {
            servicosAgendados = agendarServicoRepository
                    .findByDataAgendamentoOrderByHorarioAgendamento(dataAgendamento);
        }

        return new ReturnData<>(true, "", agendarServicoMapper.toListDto(servicosAgendados));
    }

    @Override
    public ReturnData<String> salvar(DadosAgendamentoDTO dadosAgendamentoDTO) {
        try {
            Optional<Agendamento> agendarServicoBancoDeDados =
                    agendarServicoRepository.findByDataAgendamentoAndHorarioAgendamento(
                            dadosAgendamentoDTO.getHorarioAgendamento().getDataAgendamento(),
                            dadosAgendamentoDTO.getHorarioAgendamento().getHorarioAgendamento());

            if (agendarServicoBancoDeDados.isEmpty()) {
                Optional<Empresa> empresa = empresaRepository.findById(dadosAgendamentoDTO.getEmpresaId());
                Optional<Usuario> cliente = usuarioRepository.findByEmail(dadosAgendamentoDTO.getClienteEmail());
                Optional<Usuario> funcionario = usuarioRepository.findById(dadosAgendamentoDTO.getFuncionarioId());

                AgendamentoDTO agendamentoDTO = new AgendamentoDTO();

                agendamentoDTO.setDataCadastro(new Date());
                agendamentoDTO.setDataAgendamento(dadosAgendamentoDTO.getHorarioAgendamento().getDataAgendamento());
                agendamentoDTO.setHorarioAgendamento(dadosAgendamentoDTO.getHorarioAgendamento().getHorarioAgendamento());
                agendamentoDTO.setServicos(dadosAgendamentoDTO.getServicosSelecionados());
                agendamentoDTO.setSituacao(situacaoRepository.findByName("AGENDADO").get());
                agendamentoDTO.setCliente(usuarioMapper.toDto(cliente.get()));
                agendamentoDTO.setFuncionario(usuarioMapper.toDto(funcionario.get()));
                agendamentoDTO.setEmpresa(empresaMapper.toDto(empresa.get()));

                agendarServicoRepository.saveAndFlush(agendarServicoMapper.toEntity(agendamentoDTO));

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
            Optional<Agendamento> agendarServico = agendarServicoRepository.findById(agendamentoDTO.getId());

            agendarServico.get().setSituacao(situacaoRepository.findByName("CANCELADO").get());

            agendarServicoRepository.saveAndFlush(agendarServico.get());

            return new ReturnData<>(false, "Serviço cancelado com sucesso.", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao cancelar o serviço", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao cancelar o um serviço",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }
}
