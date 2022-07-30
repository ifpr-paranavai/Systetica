package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.mapper.UsuarioMapper;
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

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@SpringBootTest
@ActiveProfiles(profiles = "local")
@AutoConfigureMockMvc
@DisplayName("UsuarioServiceTest")
public class UsuarioServiceTest {
    @MockBean
    private UsuarioRepository usuarioRepository;

    @MockBean
    private UsuarioMapper usuarioMapper;

    @Autowired
    private UsuarioServiceImpl usuarioService;

    @MockBean
    private RoleService roleService;

    @MockBean
    private EmailService emailService;

//    @MockBean
//    private PasswordEncoder passwordEncoder;

    public UsuarioServiceTest() {
    }

    @Test
    @DisplayName("Buscar usuário por id")
    public void deveBuscarUsuarioPorId() {
        Long usuarioId = 1L;
        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);
        Mockito.when(usuarioRepository.findById(ArgumentMatchers.eq(usuarioId))).thenReturn(usuarioOptional);
        Mockito.when(usuarioMapper.toDto(usuario)).thenReturn(usuarioDTO);

        usuarioService.buscarPorId(usuarioId);
    }

    @Test
    @DisplayName("Deve informar que usário não foi encontrado")
    public void deveRetornarUsuarioNaoEncontrado() {
        Long usuarioId = 1L;
        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);
        Mockito.when(usuarioRepository.findById(ArgumentMatchers.eq(usuarioId))).thenReturn(usuarioOptional);
        Mockito.when(usuarioMapper.toDto(usuario)).thenReturn(usuarioDTO);

        usuarioService.buscarPorId(usuarioId);
    }

    @Test
    @DisplayName("Deve informar que usário não foi encontrado")
    public void deveLancarExceptionAoEfetuarVenda() {
        Long usuarioId = 0L;
        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);
        Mockito.when(usuarioMapper.toDto(usuario)).thenReturn(usuarioDTO);

        var a = usuarioService.buscarPorId(usuarioId); //todo
        Long usuarioIda = 1L;
    }

    @Test
    @DisplayName("Buscar usuário por email")
    public void deveBuscarUsuarioPorEmail() {
        String email = "mock@gmail.com";
        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);
        Mockito.when(usuarioRepository.findByEmail(ArgumentMatchers.eq(email))).thenReturn(usuarioOptional);
        Mockito.when(usuarioMapper.toDto(usuario)).thenReturn(usuarioDTO);

        usuarioService.buscarPorEmail(email, false);
    }

    @Test
    @DisplayName("Buscar todos usuários")
    public void deveBuscarTodosUsuarios() {
        List<Usuario> usuarios = Collections.emptyList();
        List<UsuarioDTO> usuariosDTO = Collections.emptyList();

        Mockito.when(usuarioRepository.findAll()).thenReturn(usuarios);
        Mockito.when(usuarioMapper.toListDto(usuarios)).thenReturn(usuariosDTO);

        usuarioService.buscarTodos();
    }

}
