package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.AgendarServico;
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
    @DisplayName("Deve busca todos os agendamento por dia")
    public void deveBuscarTodosAgendamentoPorDia() {
        String dataAgendamento = "01-01-2022";

        List<String> listaDeHorarios = new ArrayList<>();
        List<AgendarServico> servicosAgendados = new ArrayList<>();

        AgendarServico agendarServico = Mockito.mock(AgendarServico.class);
        Mockito.when(agendarServico.getHorarioAgendamento()).thenReturn(LocalTime.now());

        servicosAgendados.add(agendarServico);
        listaDeHorarios.add(agendarServico.getHorarioAgendamento().toString());

        Mockito.when(agendarServicoRepository.findByDataAgendamento(dataAgendamento)).thenReturn(servicosAgendados);

        ReturnData<Object> returnData = new ReturnData<>(true, "", listaDeHorarios);
        assertEquals(agendarServicoService.buscarTodosAgendamentoPorDia(dataAgendamento), returnData);
    }

    // Testes para ReturnData false
    @Test
    @DisplayName("Deve retorna uma lista de horários vazio")
    public void deveRetornaUmaListaDeHorarioVazio() {
        String dataAgendamento = "01-01-2022";

        List<String> listaDeHorarios = new ArrayList<>();
        List<AgendarServico> servicosAgendados = new ArrayList<>();

        AgendarServico agendarServico = Mockito.mock(AgendarServico.class);
        Mockito.when(agendarServico.getHorarioAgendamento()).thenReturn(LocalTime.now());

        Mockito.when(agendarServicoRepository.findByDataAgendamento(dataAgendamento)).thenReturn(servicosAgendados);

        ReturnData<Object> returnData = new ReturnData<>(true, "", listaDeHorarios);
        assertEquals(agendarServicoService.buscarTodosAgendamentoPorDia(dataAgendamento), returnData);
    }
}
