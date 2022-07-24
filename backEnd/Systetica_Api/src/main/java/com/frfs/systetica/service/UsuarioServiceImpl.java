package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.CidadeMapper;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.UsuarioRepository;
import com.frfs.systetica.utils.GerarCodigoAleatorio;
import com.frfs.systetica.utils.Validate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class UsuarioServiceImpl implements UsuarioService, UserDetailsService {

    private static final long OITO_HORAS_MILLISEGUNDOS = 28800000;
    private static final long DEZ_MB = 10024000L;

    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;
    private final EmailService emailService;
    private final CidadeMapper cidadeMapper;

    @Override
    public ReturnData<String> salvar(UsuarioDTO usuarioDTO) {
        try {
            if (!Validate.validateCpf(usuarioDTO.getCpf())) {
                return new ReturnData<>(false, "CPF inválido.");
            }
            if (usuarioRepository.findByCpf(usuarioDTO.getCpf()).isPresent()) {
                return new ReturnData<>(false, "CPF já esta sendo utilizado.");
            }
            if (usuarioRepository.findByEmail(usuarioDTO.getEmail()).isPresent()) {
                return new ReturnData<>(false, "Email já esta sendo utilizado.");
            }

            var codigoAleatorio = GerarCodigoAleatorio.gerarCodigo();

            var returnDataEmail = emailService.enviarEmail(true, usuarioDTO.getEmail(),
                    codigoAleatorio, usuarioDTO.getNome());

            if (!returnDataEmail.getSuccess()) {
                return returnDataEmail;
            }

            var returnDataConverteBase64 = converteFileBase64(usuarioDTO.getImagemBase64());

            if (!returnDataConverteBase64.getSuccess()) {
                return returnDataConverteBase64;
            }

            usuarioDTO.setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));
            usuarioDTO.setRoles(roleService.buscaRolePorNome("CLIENTE"));
            usuarioDTO.setDataCodigo(new Date());
            usuarioDTO.setCodigoAleatorio(codigoAleatorio);
            usuarioDTO.setImagemBase64(returnDataConverteBase64.getMessage());

            usuarioRepository.saveAndFlush(usuarioMapper.toEntity(usuarioDTO));
            return new ReturnData<>(true, "Usuário salvo com sucesso", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarPorId(Long id) {
        var usuario = usuarioRepository.findById(id);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Usuário não encontrado.",
                    "Não foi possível encontrar usuário pelo id " + id);
        }
        return new ReturnData<>(true, "", usuarioMapper.toDto(usuario.get()));
    }

    @Override
    public ReturnData<Object> buscarPorEmail(String email) {
        var usuario = usuarioRepository.findByEmail(email);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Não foi possível encontrar usuário pelo email informado",
                    "Usuário não encontrado");
        }
        return new ReturnData<>(true, "", usuarioMapper.toDto(usuario.get()));
    }

    @Override
    public ReturnData<Object> buscarTodos() {
        return new ReturnData<>(true, "", usuarioMapper.toListDto(usuarioRepository.findAll()));
    }

    @Override
    public ReturnData<String> ativar(UsuarioDTO usuarioDTO) {
        var usuario = usuarioRepository.findByEmailAndCodigoAleatorio(usuarioDTO.getEmail(),
                usuarioDTO.getCodigoAleatorio());

        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Email ou código informado é inválidio");
        } else {
            var tempoExpiracao = new Date().getTime() - usuario.get().getDataCadastro().getTime();

            if (tempoExpiracao < OITO_HORAS_MILLISEGUNDOS) {
                usuario.get().setCodigoAleatorio(null);
                usuario.get().setDataCodigo(null);
                usuario.get().setUsuarioAtivo(true);
                usuarioRepository.saveAndFlush(usuario.get());
                return new ReturnData<>(true, "Usuário ativado com sucesso");
            } else {
                return new ReturnData<>(false, "Código expirado");
            }
        }
    }

    @Override
    public ReturnData<String> gerarCodigo(UsuarioDTO usuarioDTO) {
        try {
            var usuario = usuarioRepository.findByEmailAndCpf(usuarioDTO.getEmail(), usuarioDTO.getCpf());

            if (usuario.isEmpty()) {
                return new ReturnData<>(false,
                        "Usuário não encontrado, por favor verifique os dados informados");
            } else {
                var codigoAleatorio = GerarCodigoAleatorio.gerarCodigo();

                var returnDataEmail = emailService.enviarEmail(false, usuarioDTO.getEmail(),
                        codigoAleatorio, usuario.get().getNome());

                if (returnDataEmail.getSuccess()) {
                    usuario.get().setCodigoAleatorio(codigoAleatorio);
                    usuario.get().setDataCodigo(new Date());

                    usuarioRepository.saveAndFlush(usuario.get());

                    return new ReturnData<>(true, "Código para alterar senha enviado");
                }
                return returnDataEmail;
            }
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> alterarSenha(UsuarioDTO usuarioDTO) {
        try {
            var usuario = usuarioRepository.findByEmailAndCodigoAleatorio(usuarioDTO.getEmail(),
                    usuarioDTO.getCodigoAleatorio());

            if (usuario.isEmpty()) {
                return new ReturnData<>(false, "Email ou código são inválidos");
            } else {
                usuario.get().setCodigoAleatorio(null);
                usuario.get().setDataCodigo(null);
                usuario.get().setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));

                usuarioRepository.saveAndFlush(usuario.get());
                return new ReturnData<>(true, "Senhar alterada com sucesso");
            }
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao alterar senha",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> atualizar(UsuarioDTO usuarioDTO) {
        try {
            var returnDataConverteBase64 = converteFileBase64(usuarioDTO.getImagemBase64());
            if (!returnDataConverteBase64.getSuccess()) {
                return returnDataConverteBase64;
            }

            Optional<Usuario> usuarioBanco = usuarioRepository.findById(usuarioDTO.getId());

            usuarioBanco.get().setNome(usuarioDTO.getNome());
            usuarioBanco.get().setTelefone1(usuarioDTO.getTelefone1());
            usuarioBanco.get().setTelefone2(usuarioDTO.getTelefone2());
            usuarioBanco.get().setCidade(cidadeMapper.toEntity(usuarioDTO.getCidade()));
            usuarioBanco.get().setImagemBase64(returnDataConverteBase64.getMessage());

            usuarioRepository.saveAndFlush(usuarioBanco.get());

            return new ReturnData<>(true, "Usuário atualizazdo com sucesso.");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> converteFileBase64(String imagemBase64) {

        byte[] bytesEncoded = Base64.encodeBase64(imagemBase64.getBytes());

        if (bytesEncoded.length > DEZ_MB) {
            return new ReturnData<>(true, "Imagem deve possuir menos de 10mb.");
        }

        return new ReturnData<>(true, imagemBase64);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        var usuario = usuarioRepository.findByEmail(email);

        if (usuario.isEmpty()) {
            throw new UsernameNotFoundException("Usuário não encontrado");
        }

        if (!usuario.get().getUsuarioAtivo()) {
            throw new UsernameNotFoundException("Usuário não esta ativado");
        }

        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();

        usuario.get().getRoles().forEach(role ->
                authorities.add(new SimpleGrantedAuthority(role.getName()))
        );
        return new User(usuario.get().getEmail(), usuario.get().getPassword(), authorities);
    }
}