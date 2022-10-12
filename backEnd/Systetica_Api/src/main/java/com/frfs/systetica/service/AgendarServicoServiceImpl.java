package com.frfs.systetica.service;

import com.frfs.systetica.dto.AgendamentoDTO;
import com.frfs.systetica.dto.AgendarServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.AgendarServico;
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
        List<AgendarServico> servicosAgendados = agendarServicoRepository
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
        List<AgendarServico> servicosAgendados;

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
    public ReturnData<String> salvar(AgendamentoDTO agendamentoDTO) {
        try {
            Optional<AgendarServico> agendarServicoBancoDeDados =
                    agendarServicoRepository.findByDataAgendamentoAndHorarioAgendamento(
                            agendamentoDTO.getHorarioAgendamento().getDataAgendamento(),
                            agendamentoDTO.getHorarioAgendamento().getHorarioAgendamento());

            if (agendarServicoBancoDeDados.isEmpty()) {
                Optional<Empresa> empresa = empresaRepository.findById(agendamentoDTO.getEmpresaId());
                Optional<Usuario> cliente = usuarioRepository.findByEmail(agendamentoDTO.getClienteEmail());
                Optional<Usuario> funcionario = usuarioRepository.findById(agendamentoDTO.getFuncionarioId());

                AgendarServicoDTO agendarServicoDTO = new AgendarServicoDTO();

                agendarServicoDTO.setDataCadastro(new Date());
                agendarServicoDTO.setDataAgendamento(agendamentoDTO.getHorarioAgendamento().getDataAgendamento());
                agendarServicoDTO.setHorarioAgendamento(agendamentoDTO.getHorarioAgendamento().getHorarioAgendamento());
                agendarServicoDTO.setServicos(agendamentoDTO.getServicosSelecionados());
                agendarServicoDTO.setSituacao(situacaoRepository.findByName("AGENDADO").get());
                agendarServicoDTO.setCliente(usuarioMapper.toDto(cliente.get()));
                agendarServicoDTO.setFuncionario(usuarioMapper.toDto(funcionario.get()));
                agendarServicoDTO.setEmpresa(empresaMapper.toDto(empresa.get()));

                agendarServicoRepository.saveAndFlush(agendarServicoMapper.toEntity(agendarServicoDTO));

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
    public ReturnData<String> cancelar(AgendarServicoDTO agendarServicoDTO) {
        try {
            Optional<AgendarServico> agendarServico = agendarServicoRepository.findById(agendarServicoDTO.getId());

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
