package com.frfs.systetica.service;

import com.frfs.systetica.dto.*;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.*;
import com.frfs.systetica.mapper.AgendarServicoMapper;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.ServicoMapper;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.AgendarServicoRepository;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.SituacaoRepository;
import com.frfs.systetica.repository.UsuarioRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles(profiles = "local")
@AutoConfigureMockMvc
@DisplayName("EmpresaServiceTest")
public class AgendarServicoServiceTest {
    @MockBean
    private AgendarServicoRepository agendarServicoRepository;

    @MockBean
    private UsuarioRepository usuarioRepository;

    @MockBean
    private EmpresaRepository empresaRepository;

    @MockBean
    private SituacaoRepository situacaoRepository;

    @MockBean
    private AgendarServicoMapper agendarServicoMapper;

    @MockBean
    private UsuarioMapper usuarioMapper;

    @MockBean
    private EmpresaMapper empresaMapper;

    @MockBean
    private ServicoMapper servicoMapper;

    @Autowired
    private AgendarServicoServiceImpl agendarServicoService;

    public AgendarServicoServiceTest() {
    }

    @Test
    @DisplayName("Deve salvar um agendamento")
    public void deveSalvarUmAgendamento() {
        List<ServicoDTO> servicosSelecionadosDto = new ArrayList<>();
        List<Servico> servicosSelecionadosService = new ArrayList<>();

        DadosAgendamentoDTO dadosAgendamentoDTO = Mockito.mock(DadosAgendamentoDTO.class);
        HorarioAgendamentoDTO horarioAgendamentoDTO = Mockito.mock(HorarioAgendamentoDTO.class);

        Servico servico = Mockito.mock(Servico.class);
        ServicoDTO servicoDTO = Mockito.mock(ServicoDTO.class);

        Agendamento agendarServico = Mockito.mock(Agendamento.class);
        Optional<Agendamento> agendarServicoOptional = Optional.empty();
        AgendamentoDTO agendamentoDTO = Mockito.mock(AgendamentoDTO.class);

        Empresa empresa = Mockito.mock(Empresa.class);
        Optional<Empresa> empresaOptional = Optional.of(empresa);
        EmpresaDTO empresaDTO = Mockito.mock(EmpresaDTO.class);

        Usuario cliente = Mockito.mock(Usuario.class);
        Optional<Usuario> clienteOptional = Optional.of(cliente);
        UsuarioDTO clienteDto = Mockito.mock(UsuarioDTO.class);

        Usuario funcionario = Mockito.mock(Usuario.class);
        Optional<Usuario> funcionarioOptional = Optional.of(funcionario);
        UsuarioDTO funcionarioDto = Mockito.mock(UsuarioDTO.class);

        Situacao situacao = Mockito.mock(Situacao.class);
        Optional<Situacao> situacaoOptional = Optional.of(situacao);

        Mockito.when(horarioAgendamentoDTO.getDataAgendamento()).thenReturn("01-01-2022");
        Mockito.when(horarioAgendamentoDTO.getHorarioAgendamento()).thenReturn(LocalTime.now());

        servicosSelecionadosDto.add(servicoDTO);
        servicosSelecionadosService.add(servico);

        Mockito.when(dadosAgendamentoDTO.getHorarioAgendamento()).thenReturn(horarioAgendamentoDTO);
        Mockito.when(dadosAgendamentoDTO.getServicosSelecionados()).thenReturn(servicosSelecionadosDto);

        Mockito.when(agendarServico.getId()).thenReturn(1L);
        Mockito.when(agendarServico.getServicos()).thenReturn(servicosSelecionadosService);

        Mockito.when(agendarServicoRepository
                .findByDataAgendamentoAndHorarioAgendamento(
                        horarioAgendamentoDTO.getDataAgendamento(),
                        horarioAgendamentoDTO.getHorarioAgendamento())).thenReturn(agendarServicoOptional);

        Mockito.when(empresaRepository.findById(dadosAgendamentoDTO.getEmpresaId())).thenReturn(empresaOptional);
        Mockito.when(usuarioRepository.findByEmail(dadosAgendamentoDTO.getClienteEmail())).thenReturn(clienteOptional);
        Mockito.when(usuarioRepository.findById(dadosAgendamentoDTO.getFuncionarioId())).thenReturn(funcionarioOptional);
        Mockito.when(situacaoRepository.findByName("AGENDADO")).thenReturn(situacaoOptional);

        Mockito.when(empresaMapper.toDto(empresa)).thenReturn(empresaDTO);
        Mockito.when(usuarioMapper.toDto(cliente)).thenReturn(clienteDto);
        Mockito.when(usuarioMapper.toDto(funcionario)).thenReturn(funcionarioDto);
        Mockito.when(agendarServicoMapper.toEntity(agendamentoDTO)).thenReturn(agendarServico);
        Mockito.when(servicoMapper.toListEntity(dadosAgendamentoDTO.getServicosSelecionados()))
                .thenReturn(servicosSelecionadosService);

        Mockito.when(agendarServicoRepository.saveAndFlush(agendarServico)).thenReturn(agendarServico);

        ReturnData<Object> returnData = new ReturnData<>(true, "Serviço agendado com sucesso.", "");
        assertEquals(agendarServicoService.salvar(dadosAgendamentoDTO), returnData);
    }

//    @Test
//    @DisplayName("Deve busca todos os agendamento por dia")
//    public void deveBuscarTodosAgendamentoPorDia() {
//        String dataAgendamento = "01-01-2022";
//
//        List<String> listaDeHorarios = new ArrayList<>();
//        List<AgendarServico> servicosAgendados = new ArrayList<>();
//
//        AgendarServico agendarServico = Mockito.mock(AgendarServico.class);
//        Mockito.when(agendarServico.getHorarioAgendamento()).thenReturn(LocalTime.now());
//
//        servicosAgendados.add(agendarServico);
//        listaDeHorarios.add(agendarServico.getHorarioAgendamento().toString());
//
//        Mockito.when(agendarServicoRepository.findByDataAgendamento(dataAgendamento)).thenReturn(servicosAgendados);
//
//        ReturnData<Object> returnData = new ReturnData<>(true, "", listaDeHorarios);
//        assertEquals(agendarServicoService.buscarTodosAgendamentoPorDia(dataAgendamento), returnData);
//    }
//
//    // Testes para ReturnData false
//    @Test
//    @DisplayName("Deve retorna uma lista de horários vazio")
//    public void deveRetornaUmaListaDeHorarioVazio() {
//        String dataAgendamento = "01-01-2022";
//
//        List<String> listaDeHorarios = new ArrayList<>();
//        List<AgendarServico> servicosAgendados = new ArrayList<>();
//
//        AgendarServico agendarServico = Mockito.mock(AgendarServico.class);
//        Mockito.when(agendarServico.getHorarioAgendamento()).thenReturn(LocalTime.now());
//
//        Mockito.when(agendarServicoRepository.findByDataAgendamento(dataAgendamento)).thenReturn(servicosAgendados);
//
//        ReturnData<Object> returnData = new ReturnData<>(true, "", listaDeHorarios);
//        assertEquals(agendarServicoService.buscarTodosAgendamentoPorDia(dataAgendamento), returnData);
//    }

    @Test
    @DisplayName("Deve informar que já foi agendado um serviço para aquele horário")
    public void deveInformarQueJaFoiAgendadoUmServico() {
        List<ServicoDTO> servicosSelecionadosDto = new ArrayList<>();
        DadosAgendamentoDTO dadosAgendamentoDTO = Mockito.mock(DadosAgendamentoDTO.class);
        HorarioAgendamentoDTO horarioAgendamentoDTO = Mockito.mock(HorarioAgendamentoDTO.class);

        Agendamento agendarServico = Mockito.mock(Agendamento.class);
        Optional<Agendamento> agendarServicoOptional = Optional.of(agendarServico);

        Mockito.when(horarioAgendamentoDTO.getDataAgendamento()).thenReturn("01-01-2022");
        Mockito.when(horarioAgendamentoDTO.getHorarioAgendamento()).thenReturn(LocalTime.now());

        Mockito.when(dadosAgendamentoDTO.getHorarioAgendamento()).thenReturn(horarioAgendamentoDTO);
        Mockito.when(dadosAgendamentoDTO.getServicosSelecionados()).thenReturn(servicosSelecionadosDto);

        Mockito.when(agendarServicoRepository
                .findByDataAgendamentoAndHorarioAgendamento(
                        horarioAgendamentoDTO.getDataAgendamento(),
                        horarioAgendamentoDTO.getHorarioAgendamento())).thenReturn(agendarServicoOptional);

        ReturnData<Object> returnData = new ReturnData<>(false, "Já foi agendado um serviço para o horário selecionado.", "");
        assertEquals(agendarServicoService.salvar(dadosAgendamentoDTO), returnData);
    }
}
