package com.frfs.systetica.service;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Empresa;
import com.frfs.systetica.entity.Role;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.mapper.EmpresaMapper;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.EmpresaRepository;
import com.frfs.systetica.repository.RoleRepository;
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
    private RoleRepository roleRepository;

    @MockBean
    private EmailService emailService;

    @MockBean
    private CodigoAleatorioService codigoAleatorioService;

    @Autowired
    private UsuarioServiceImpl usuarioService;

    @MockBean
    private EmpresaRepository empresaRepository;

    @MockBean
    private EmpresaMapper empresaMapper;

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
                usuarioDTO.getEmail(),
                codigoAleatorio,
                usuarioDTO.getNome())
        ).thenReturn(new ReturnData<>(true, "", "Código enviado com sucesso!"));

        Mockito.when(passwordEncoder.encode(ArgumentMatchers.eq("123123"))).thenReturn(passwordEncode);
        Mockito.when(roleService.buscaRolePorNome(ArgumentMatchers.eq("CLIENTE"))).thenReturn(roles);

        Mockito.when(usuarioMapper.toEntity(usuarioDTO)).thenReturn(usuario);
        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);

        ReturnData<String> returnData = new ReturnData<>(true, "Usuário salvo com sucesso", "");
        assertEquals(usuarioService.salvar(usuarioDTO), returnData);
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

        ReturnData<Object> returnData = new ReturnData<>(true, "", usuarioDTO);
        assertEquals(usuarioService.buscarPorId(usuarioId), returnData);
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

        ReturnData<Object> returnData = new ReturnData<>(true, "", usuarioDTO);
        assertEquals(usuarioService.buscarPorEmail(email, false), returnData);
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

        ReturnData<String> returnData = new ReturnData<>(true, "Usuário ativado com sucesso");
        assertEquals(usuarioService.ativar(usuarioDTO), returnData);
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

                usuario.getEmail(),
                codigoAleatorio,
                usuario.getNome())
        ).thenReturn(new ReturnData<>(true, "", "Código enviado com sucesso!"));

        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);

        ReturnData<String> returnData = new ReturnData<>(true, "Código para alterar senha enviado");
        assertEquals(usuarioService.gerarCodigoAleatorio(email), returnData);
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

        ReturnData<String> returnData = new ReturnData<>(true, "Senha alterada com sucesso");
        assertEquals(usuarioService.alterarSenha(usuarioDTO), returnData);
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

        ReturnData<String> returnData = new ReturnData<>(true, "Usuário atualizado com sucesso.");
        assertEquals(usuarioService.atualizar(usuarioDTO), returnData);
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

    @Test
    @DisplayName("Deve conceder permissão de funcionário")
    public void deveConcederPermissaoFuncionario() {
        String email = "usuario@gmail.com";
        Collection<Role> roles = new ArrayList<>();

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Empresa empresa = Mockito.mock(Empresa.class);
        Optional<Empresa> empresaOptional = Optional.of(empresa);

        Role roleCliente = Mockito.mock(Role.class);
        Mockito.when(roleCliente.getId()).thenReturn(1L);
        Mockito.when(roleCliente.getName()).thenReturn("CLIENTE");

        Role roleFuncionario = Mockito.mock(Role.class);
        Mockito.when(roleFuncionario.getId()).thenReturn(2L);
        Mockito.when(roleFuncionario.getName()).thenReturn("FUNCIONARIO");

        roles.add(roleCliente);

        Mockito.when(usuarioOptional.get().getId()).thenReturn(1L);
        Mockito.when(usuarioOptional.get().getRoles()).thenReturn(roles);

        Mockito.when(usuarioDTO.getEmail()).thenReturn(email);
        Mockito.when(usuarioDTO.getPermissaoFuncionario()).thenReturn(true);
        Mockito.when(usuarioDTO.getEmailAdministrativo()).thenReturn("systetica@gmail.com");

        Mockito.when(usuarioRepository.findByEmail(email)).thenReturn(usuarioOptional);
        Mockito.when(empresaRepository.findByUsuarioAdministradorEmail(usuarioDTO.getEmailAdministrativo()))
                .thenReturn(empresaOptional);
        Mockito.when(roleRepository.findByName("FUNCIONARIO")).thenReturn(roleFuncionario);
        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);

        ReturnData<String> returnData = new ReturnData<>(true, "Permissão concedida com sucesso.");
        assertEquals(usuarioService.concederPermissaoFuncionairo(usuarioDTO), returnData);
    }

    @Test
    @DisplayName("Deve remover permissão de funcionário")
    public void deveRemoverrPermissaoFuncionario() {
        String email = "usuario@gmail.com";
        Collection<Role> roles = new ArrayList<>();

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);
        Optional<Usuario> usuarioOptional = Optional.of(usuario);

        Role roleCliente = Mockito.mock(Role.class);
        Mockito.when(roleCliente.getId()).thenReturn(1L);
        Mockito.when(roleCliente.getName()).thenReturn("CLIENTE");

        Role roleFuncionario = Mockito.mock(Role.class);
        Mockito.when(roleFuncionario.getId()).thenReturn(2L);
        Mockito.when(roleFuncionario.getName()).thenReturn("FUNCIONARIO");

        roles.add(roleFuncionario);

        Mockito.when(usuarioOptional.get().getId()).thenReturn(1L);
        Mockito.when(usuarioOptional.get().getRoles()).thenReturn(roles);

        Mockito.when(usuarioDTO.getEmail()).thenReturn(email);
        Mockito.when(usuarioDTO.getPermissaoFuncionario()).thenReturn(false);
        Mockito.when(usuarioDTO.getEmailAdministrativo()).thenReturn("systetica@gmail.com");

        Mockito.when(usuarioRepository.findByEmail(email)).thenReturn(usuarioOptional);
        Mockito.when(roleRepository.findByName("CLIENTE")).thenReturn(roleCliente);
        Mockito.when(usuarioRepository.saveAndFlush(ArgumentMatchers.any(Usuario.class))).thenReturn(usuario);

        ReturnData<String> returnData = new ReturnData<>(true, "Permissão concedida com sucesso.");
        assertEquals(usuarioService.concederPermissaoFuncionairo(usuarioDTO), returnData);
    }

    @Test
    @DisplayName("Buscar funcionários por empra")
    public void deveBuscarFuncionariosPorEmpresa() {
        List<UsuarioDTO> usuariosDtos = new ArrayList<>();
        List<Usuario> usuarios = new ArrayList<>();
        String email = "mock@gmail.com";

        Usuario usuario = Mockito.mock(Usuario.class);
        UsuarioDTO usuarioDTO = Mockito.mock(UsuarioDTO.class);

        Empresa empresa = Mockito.mock(Empresa.class);
        EmpresaDTO empresaDTO = Mockito.mock(EmpresaDTO.class);
        Optional<Empresa> empresaOptional = Optional.of(empresa);

        Mockito.when(usuario.getId()).thenReturn(1L);
        Mockito.when(usuario.getNome()).thenReturn("teste nome");

        Mockito.when(usuarioDTO.getId()).thenReturn(1L);
        Mockito.when(usuarioDTO.getNome()).thenReturn("teste nome");

        usuarios.add(usuario);
        usuariosDtos.add(usuarioDTO);

        Mockito.when(empresa.getId()).thenReturn(1L);
        Mockito.when(empresa.getNome()).thenReturn("Systetica");
        Mockito.when(empresa.getUsuarios()).thenReturn(usuarios);

        Mockito.when(empresaDTO.getId()).thenReturn(1L);
        Mockito.when(empresaDTO.getNome()).thenReturn("Systetica");
        Mockito.when(empresaDTO.getUsuarios()).thenReturn(usuariosDtos);

        Mockito.when(empresaRepository.findByUsuarioAdministradorEmail(ArgumentMatchers.eq(email)))
                .thenReturn(empresaOptional);
        Mockito.when(empresaMapper.toDto(empresa)).thenReturn(empresaDTO);

        ReturnData<Object> returnData = new ReturnData<>(true, "", usuariosDtos);

        assertEquals(usuarioService.buscarFuncionarios(email), returnData);
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

        ReturnData<String> returnData = new ReturnData<>(false, "Email ou Código inválido");

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

        assertEquals(usuarioService.gerarCodigoAleatorio(email), returnData);
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

        ReturnData<String> returnData = new ReturnData<>(false, "Email ou Código inválido");

        assertEquals(usuarioService.alterarSenha(usuarioDTO), returnData);
    }

    @Test
    @DisplayName("Deve informa que empresa não foi encontrada")
    public void deveInformaEmpresaNaoEncontrada() {
        String email = "mock@gmail.com";

        Optional<Empresa> empresaOptional = Optional.empty();
        Mockito.when(empresaRepository.findByUsuarioAdministradorEmail(email)).thenReturn(empresaOptional);

        ReturnData<Object> returnData = new ReturnData<>(false, "Empresa não encontrada",
                "Não foi possível encontrar empresa pelo email " + email);
        assertEquals(usuarioService.buscarFuncionarios(email), returnData);
    }
}
