package com.frfs.systetica.service;

import com.frfs.systetica.dto.CidadeDTO;
import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Cidade;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.mapper.CidadeMapper;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.UsuarioRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@ActiveProfiles(profiles = "local")
@AutoConfigureMockMvc
@DisplayName("EmpresaServiceTest")
public class EmpresaServiceTest {
    @MockBean
    private EmpresaRepository empresaRepository;

    @MockBean
    private EmpresaMapper empresaMapper;

    @MockBean
    private UsuarioRepository usuarioRepository;

    @MockBean
    private UsuarioMapper usuarioMapper;

    @MockBean
    private CidadeMapper cidadeMapper;

    @Autowired
    private EmpresaServiceImpl empresaService;

    public EmpresaServiceTest() {
    }

    @Test
    @DisplayName("Buscar salvar um empresa")
    public void deveSalvarEmpresa() {
        String imagemBase64 = "abcdefgh";
        Empresa empresa = Mockito.mock(Empresa.class);
        EmpresaDTO empresaDTO = Mockito.mock(EmpresaDTO.class);
        Optional<Empresa> empresaOptional = Optional.of(empresa);

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuarioDTO.getEmail()).thenReturn("mock@gmail.com");

        Mockito.when(empresaDTO.getNome()).thenReturn("Systetica Ltda");
        Mockito.when(empresaDTO.getCnpj()).thenReturn("82.111.465/0001-00");
        Mockito.when(empresaDTO.getUsuarioAdministrador()).thenReturn(usuarioDTO);
        Mockito.when(empresaDTO.getLogoBase64()).thenReturn(imagemBase64);

        Mockito.when(empresaRepository.findByCnpj(ArgumentMatchers.eq("46.565.465/0001-45"))).thenReturn(empresaOptional);
        Mockito.when(usuarioRepository.findByEmail(ArgumentMatchers.eq("mock@gmail.com"))).thenReturn(usuarioOptional);
        Mockito.when(usuarioMapper.toDto(usuarioOptional.get())).thenReturn(usuarioDTO);

        ReturnData<String> returnData = new ReturnData<>(true, "Empresa salva com sucesso", "");
        assertEquals(empresaService.salvar(empresaDTO), returnData);
    }
}
