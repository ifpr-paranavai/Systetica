package com.frfs.systetica.service;

import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Role;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.UsuarioRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ActiveProfiles;

import java.util.*;

@SpringBootTest
@ActiveProfiles(profiles = "local")
@AutoConfigureMockMvc
@DisplayName("UsuarioServiceTest")
public class UsuarioServiceTest {
    @MockBean
    private UsuarioRepository usuarioRepository;

    @MockBean
    private UsuarioMapper usuarioMapper;

    @MockBean
    private RoleService roleService;

    @MockBean
    private EmailService emailService;

    @MockBean
    private CodigoAleatorioService codigoAleatorioService;

    @Autowired
    private UsuarioServiceImpl usuarioService;

    @Mock
    private PasswordEncoder passwordEncoder;

    public UsuarioServiceTest() {
    }

    @Test
    @DisplayName("Buscar salvar um usuário")
    public void deveSalvarUsuario() {
        int codigoAleatorio = 123456;
        String passwordEncode = "$2a$10$WDZeDn3P0qt8.mUgZcji1uAw9BJG4s2bFTiuIwVNsL7h.iYOkDImK";

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        RoleDTO role = Mockito.mock(RoleDTO.class);
        Mockito.when(role.getId()).thenReturn(1L);
        Mockito.when(role.getName()).thenReturn("CLIENTE");

        List<RoleDTO> roles = Collections.singletonList(role);

        Mockito.when(usuarioDTO.getNome()).thenReturn("Systetica App");
        Mockito.when(usuarioDTO.getEmail()).thenReturn("systetica@gmail.com");
        Mockito.when(usuarioDTO.getPassword()).thenReturn(passwordEncode);
        Mockito.when(usuarioDTO.getRoles()).thenReturn(roles);

        Mockito.when(usuarioRepository.findByEmail(ArgumentMatchers.eq("mock@gmail.com"))).thenReturn(usuarioOptional);
        Mockito.when(codigoAleatorioService.gerarCodigo()).thenReturn(123456);
        Mockito.when(emailService.enviarEmail(
                true,
                usuarioDTO.getEmail(),
                codigoAleatorio,
                usuarioDTO.getNome())
        ).thenReturn(new ReturnData<>(true, "", "Código enviado com sucesso!"));

        Mockito.when(passwordEncoder.encode(ArgumentMatchers.eq("123123"))).thenReturn(passwordEncode);
        Mockito.when(roleService.buscaRolePorNome(ArgumentMatchers.eq("CLIENTE"))).thenReturn(roles);


        Mockito.when(usuarioMapper.toEntity(usuarioDTO)).thenReturn(usuario);
        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);

        usuarioService.salvar(usuarioDTO);
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

    @Test
    @DisplayName("Deve ativar usuário todos usuários")
    public void deveAtivarUsuario() {
        int codigoAleatorio = 123456;
        String email = "systetica@gmail.com";

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuarioDTO.getEmail()).thenReturn(email);
        Mockito.when(usuarioDTO.getCodigoAleatorio()).thenReturn(codigoAleatorio);

        Mockito.when(usuarioOptional.get().getDataCadastro()).thenReturn(new Date());

        Mockito.when(usuarioRepository.findByEmailAndCodigoAleatorio(
                email,
                codigoAleatorio
        )).thenReturn(usuarioOptional);

        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);
        usuarioService.ativar(usuarioDTO);
    }

    @Test
    @DisplayName("Deve gerar um código aleatório para alterar senha")
    public void deveGerarCodigoAlterarSenha() {
        int codigoAleatorio = 123456;
        String email = "systetica@gmail.com";

        Usuario usuario = Mockito.mock(Usuario.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuario.getNome()).thenReturn("systetica");
        Mockito.when(usuario.getEmail()).thenReturn(email);

        Mockito.when(usuarioRepository.findByEmail(email)).thenReturn(usuarioOptional);

        Mockito.when(codigoAleatorioService.gerarCodigo()).thenReturn(123456);

        Mockito.when(emailService.enviarEmail(
                false,
                usuario.getEmail(),
                codigoAleatorio,
                usuario.getNome())
        ).thenReturn(new ReturnData<>(true, "", "Código enviado com sucesso!"));

        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);
        usuarioService.gerarCodigoAlterarSenha(email);
    }

    @Test
    @DisplayName("Deve alterar a senha do usuário")
    public void deveAlterarSenha() {
        int codigoAleatorio = 123456;
        String passwordEncode = "$2a$10$WDZeDn3P0qt8.mUgZcji1uAw9BJG4s2bFTiuIwVNsL7h.iYOkDImK";

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuarioDTO.getEmail()).thenReturn("systetica@gmail.com");
        Mockito.when(usuarioDTO.getCodigoAleatorio()).thenReturn(codigoAleatorio);
        Mockito.when(usuarioDTO.getPassword()).thenReturn(passwordEncode);

        Mockito.when(usuarioRepository.findByEmailAndCodigoAleatorio(
                usuarioDTO.getEmail(),
                codigoAleatorio
        )).thenReturn(usuarioOptional);

        Mockito.when(passwordEncoder.encode(ArgumentMatchers.eq("123123"))).thenReturn(passwordEncode);

        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);
        usuarioService.alterarSenha(usuarioDTO);
    }

    @Test
    @DisplayName("Deve atualizar dados do usuário")
    public void deveAtualizarUsuario() {
        String imagemBase64 = "abcdefgh";
        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuarioDTO.getId()).thenReturn(1L);
        Mockito.when(usuarioDTO.getImagemBase64()).thenReturn(imagemBase64);

        Mockito.when(usuarioRepository.findById(usuarioDTO.getId())).thenReturn(usuarioOptional);

        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);
        usuarioService.atualizar(usuarioDTO);
    }

    @Test
    @DisplayName("Deve converter imagem em base 64")
    public void deveConverteFileBase64() {
        String imagemBase64 = "imagembase64paratestedemetodo";

        usuarioService.converteFileBase64(imagemBase64);
    }

    @Test
    @DisplayName("Deve carregar/retorna usuáriolo pelo email")
    public void deveCarregarUsuarioPorEmail() {
        String email = "systetica@gmail.com";

        Usuario usuario = Mockito.mock(Usuario.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Role role = Mockito.mock(Role.class);
        Mockito.when(role.getId()).thenReturn(1L);
        Mockito.when(role.getName()).thenReturn("CLIENTE");

        Collection<Role> roles = Collections.singletonList(role);

        Mockito.when(usuarioRepository.findByEmail(email)).thenReturn(usuarioOptional);
        Mockito.when(usuarioOptional.get().getEmail()).thenReturn(email);
        Mockito.when(usuarioOptional.get().getUsuarioAtivo()).thenReturn(true);
        Mockito.when(usuarioOptional.get().getPassword()).thenReturn("$2a$10$WDZeDn3P0qt8.mUgZcji1uAw9BJG4s2bFTiuIwVNsL7h.iYOkDImK");
        Mockito.when(usuarioOptional.get().getRoles()).thenReturn(roles);

        usuarioService.loadUserByUsername(email);
    }
}
