package com.frfs.systetica.service;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.entity.Servico;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.ServicoMapper;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.ServicoRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;

import java.util.Date;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles(profiles = "local")
@AutoConfigureMockMvc
@DisplayName("ServicoServiceTest")
public class ServicoServiceTest {

    @MockBean
    private ServicoRepository servicoRepository;

    @MockBean
    private ServicoMapper servicoMapper;

    @MockBean
    private EmpresaMapper empresaMapper;

    @MockBean
    private EmpresaRepository empresaRepository;

    @Autowired
    private ServicoServiceImpl servicoService;

    public ServicoServiceTest() {
    }

    @Test
    @DisplayName("Deve salvar um serviço")
    public void deveSalvarServico() {
        String emailAdministrativo = "systetica@gmail.com.br";

        Servico servico = Mockito.mock(Servico.class);
        ServicoDTO servicoDTO = Mockito.mock(ServicoDTO.class);

        Empresa empresa = Mockito.mock(Empresa.class);
        EmpresaDTO empresaDTO = Mockito.mock(EmpresaDTO.class);
        Optional<Empresa> empresaOptional = Optional.of(empresa);

        Mockito.when(empresaOptional.get().getId()).thenReturn(1L);

        Mockito.when(servicoDTO.getNome()).thenReturn("Corte de cabelo");
        Mockito.when(servicoDTO.getTempoServico()).thenReturn(60);
        Mockito.when(servicoDTO.getEmailAdministrativo()).thenReturn(emailAdministrativo);
        Mockito.when(servicoDTO.getEmpresa()).thenReturn(empresaDTO);

        Mockito.when(empresaRepository.findByUsuarioAdministradorEmail(ArgumentMatchers.eq(emailAdministrativo)))
                .thenReturn(empresaOptional);
        Mockito.when(empresaMapper.toDto(empresaOptional.get())).thenReturn(empresaDTO);
        Mockito.when(servicoMapper.toEntity(servicoDTO)).thenReturn(servico);

        ReturnData<String> returnData = new ReturnData<>(true, "Servico salvo com sucesso", "");
        assertEquals(servicoService.salvar(servicoDTO), returnData);
    }

    @Test
    @DisplayName("Deve atualizar um servico")
    public void deveAtualizarServicoa() {
        Servico servico = Mockito.mock(Servico.class);
        ServicoDTO servicoDTO = Mockito.mock(ServicoDTO.class);
        Optional<Servico> servicoOptional = Optional.of(servico);

        Mockito.when(servicoDTO.getId()).thenReturn(1L);
        Mockito.when(servico.getDataCadastro()).thenReturn(new Date());

        Mockito.when(servicoRepository.findById(servicoDTO.getId())).thenReturn(servicoOptional);
        Mockito.when(servicoMapper.toEntity(servicoDTO)).thenReturn(servico);

        ReturnData<String> returnData = new ReturnData<>(true, "Servico atualizado com sucesso.");
        assertEquals(servicoService.atualizar(servicoDTO), returnData);
    }

    // Testes para ReturnData false
    @Test
    @DisplayName("Deve informa que empresa não foi encontrada")
    public void deveInformaEmpresaNaoEncontrada() {
        ServicoDTO servicoDTO = Mockito.mock(ServicoDTO.class);

        Optional<Empresa> empresaOptional = Optional.empty();

        Mockito.when(empresaRepository.findByUsuarioAdministradorEmail(
                ArgumentMatchers.eq("systetica@gmail.com.br"))).thenReturn(empresaOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Empresa não encontrada",
                "Não foi possível encontrar empresa cadastrada para salvar serviço");
        assertEquals(servicoService.salvar(servicoDTO), returnData);
    }
}
