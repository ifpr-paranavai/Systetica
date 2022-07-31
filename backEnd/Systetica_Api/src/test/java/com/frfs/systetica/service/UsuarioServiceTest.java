package com.frfs.systetica.service;

import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Role;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.UsuarioRepository;
import org.apache.commons.lang3.RandomStringUtils;
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

import static org.junit.jupiter.api.Assertions.assertEquals;

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

    // Testes para ReturnData false
    @Test
    @DisplayName("Deve informa que o email já esta sendo utilizado")
    public void deveInformarEmailUtilizado() {

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuarioDTO.getEmail()).thenReturn("systetica@gmail.com");
        Mockito.when(usuarioRepository.findByEmail(ArgumentMatchers.eq("systetica@gmail.com"))).thenReturn(usuarioOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Email já esta sendo utilizado.");

        assertEquals(usuarioService.salvar(usuarioDTO), returnData);
    }

    @Test
    @DisplayName("Deve informar que ocorreu algum erro para enviar email ao salvar usuario")
    public void deveInformarQueEmailNaoEnviado() {
        int codigoAleatorio = 123456;

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuarioDTO.getNome()).thenReturn("Systetica App");
        Mockito.when(usuarioDTO.getEmail()).thenReturn("systetica@gmail.com");

        ReturnData<String> returnDataEmail = new ReturnData<>(false, "", "Ocorreu algum erro ao enviar email!");

        Mockito.when(usuarioRepository.findByEmail(ArgumentMatchers.eq("mock@gmail.com"))).thenReturn(usuarioOptional);
        Mockito.when(codigoAleatorioService.gerarCodigo()).thenReturn(123456);
        Mockito.when(emailService.enviarEmail(
                true,
                usuarioDTO.getEmail(),
                codigoAleatorio,
                usuarioDTO.getNome())
        ).thenReturn(returnDataEmail);

        assertEquals(usuarioService.salvar(usuarioDTO), returnDataEmail);
    }

    @Test
    @DisplayName("Deve informar que usuário não foi encontrado por id")
    public void deveInformaUsuarioNaoEncontradoPorId() {
        Long usuarioId = 1L;
        Optional<Usuario> usuarioOptional = Optional.empty();

        Mockito.when(usuarioRepository.findById(ArgumentMatchers.eq(usuarioId))).thenReturn(usuarioOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Usuário não encontrado.",
                "Não foi possível encontrar usuário pelo id " + usuarioId);

        assertEquals(usuarioService.buscarPorId(usuarioId), returnData);
    }

    @Test
    @DisplayName("Buscar informar que usuário não foi encontrado por email")
    public void deveInformaUsuarioNaoEncontradoPorEmail() {
        String email = "mock@gmail.com";

        Optional<Usuario> usuarioOptional = Optional.empty();
        Mockito.when(usuarioRepository.findByEmail(ArgumentMatchers.eq(email))).thenReturn(usuarioOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Usuário não encontrado.",
                "Não foi possível encontrar usuário pelo email" + email);

        assertEquals(usuarioService.buscarPorEmail(email, false), returnData);
    }

    @Test
    @DisplayName("Buscar informar que email ou código é inválido")
    public void deveInformaEmailCodigoInformadoInvalido() {
        int codigoAleatorio = 123456;
        String email = "systetica@gmail.com";

        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.empty();

        Mockito.when(usuarioRepository.findByEmailAndCodigoAleatorio(
                email,
                codigoAleatorio
        )).thenReturn(usuarioOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Email ou código informado inválido");

        assertEquals(usuarioService.ativar(usuarioDTO), returnData);
    }

    @Test
    @DisplayName("Deve informar código aleatório expirado")
    public void deveInformarCodigoExpirado() {
        int codigoAleatorio = 123456;
        String email = "systetica@gmail.com";

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Mockito.when(usuarioDTO.getEmail()).thenReturn(email);
        Mockito.when(usuarioDTO.getCodigoAleatorio()).thenReturn(codigoAleatorio);

        Mockito.when(usuarioOptional.get().getDataCadastro())
                .thenReturn(new GregorianCalendar(2020, Calendar.FEBRUARY, 11).getTime());

        Mockito.when(usuarioRepository.findByEmailAndCodigoAleatorio(
                email,
                codigoAleatorio
        )).thenReturn(usuarioOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Código expirado");

        assertEquals(usuarioService.ativar(usuarioDTO), returnData);
    }

    @Test
    @DisplayName("Buscar informar que usuário não foi encontrado por email")
    public void deveInformaUsuarioNaoEncontradoPorEmailInformado() {
        String email = "mock@gmail.com";

        Optional<Usuario> usuarioOptional = Optional.empty();
        Mockito.when(usuarioRepository.findByEmail(ArgumentMatchers.eq(email))).thenReturn(usuarioOptional);

        ReturnData<String> returnData = new ReturnData<>(false,
                "Usuário não encontrado, por favor verifique email informado");

        assertEquals(usuarioService.gerarCodigoAlterarSenha(email), returnData);
    }

    @Test
    @DisplayName("Deve informar que email ou código são invalido para alterar senha")
    public void deveInformarEmailCodigoInvalidoAlterarSenha() {
        int codigoAleatorio = 123456;

        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.empty();

        Mockito.when(usuarioDTO.getEmail()).thenReturn("systetica@gmail.com");
        Mockito.when(usuarioDTO.getCodigoAleatorio()).thenReturn(codigoAleatorio);

        Mockito.when(usuarioRepository.findByEmailAndCodigoAleatorio(
                usuarioDTO.getEmail(),
                usuarioDTO.getCodigoAleatorio()
        )).thenReturn(usuarioOptional);

        ReturnData<String> returnData = new ReturnData<>(false, "Email ou código são inválidos");

        assertEquals(usuarioService.alterarSenha(usuarioDTO), returnData);
    }

    @Test
    @DisplayName("Deve informar que imagem deve possuir menos de 10mb")
    public void deveInformarImagemDeveSerMenorDezMb() {
        String imagemBase64 = RandomStringUtils.randomAscii(11485760);

        ReturnData<String> returnData = new ReturnData<>(false, "Imagem deve possuir menos de 10mb.");

        assertEquals(usuarioService.converteFileBase64(imagemBase64), returnData);
    }

}
