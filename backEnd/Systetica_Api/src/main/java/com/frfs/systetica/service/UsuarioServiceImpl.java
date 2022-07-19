package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.UsuarioRepository;
import com.frfs.systetica.utils.GerarCodigoAleatorio;
import com.frfs.systetica.utils.Validate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

@Service
@RequiredArgsConstructor
@Slf4j
public class UsuarioServiceImpl implements UsuarioService, UserDetailsService {

    private static final long DEZ_MINUTOS_MILLISECUNDOS = 600000;

    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;
    private final EmailService emailService;

    @Override
    public ReturnData<String> salvar(UsuarioDTO usuarioDTO) {
        try {
            if (!Validate.validateCpf(usuarioDTO.getCpf()
                    .replace(".", "")
                    .replace("-", ""))
            ) {
                return new ReturnData<>(false, "CPF inválido.");
            }
            if (usuarioRepository.findByCpf(usuarioDTO.getCpf()).isPresent()) {
                return new ReturnData<>(false, "CPF já esta sendo utilizado.");
            }
            if (usuarioRepository.findByEmail(usuarioDTO.getEmail()).isPresent()) {
                return new ReturnData<>(false, "Email já esta sendo utilizado.");
            }

            usuarioDTO.setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));

            usuarioDTO = roleService.adicionarRoleUsuario(usuarioDTO, "CLIENTE");

            var codigoAleatorio = GerarCodigoAleatorio.gerarCodigo();

            var returnDataEmail = emailService.enviarEmail(true, usuarioDTO.getEmail(), codigoAleatorio, usuarioDTO.getNome());

            if (returnDataEmail.getSuccess()) {
                usuarioDTO.setDataCodigo(new Date());
                usuarioDTO.setCodigoAleatorio(codigoAleatorio);

                usuarioRepository.saveAndFlush(usuarioMapper.toEntity(usuarioDTO));
                return new ReturnData<>(true, "Usuário salvo com sucesso", "");
            }
            return returnDataEmail;
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarPorId(Long id) {
        var usuario = usuarioRepository.findById(id);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Usuário não encontrado.", "Não foi possível encontrar usuário pelo id " + id);
        }
        return new ReturnData<>(true, "", usuario);
    }

    @Override
    public ReturnData<Object> buscarPorEmail(String email) {
        var usuario = usuarioRepository.findByEmail(email);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Não foi possível encontrar usuário pelo email informado", "Usuário não encontrado");
        }
        return new ReturnData<>(true, "", usuario.get());
    }

    @Override
    public ReturnData<Object> buscarTodos() {
        return new ReturnData<>(true, "", usuarioMapper.toListDto(usuarioRepository.findAll()));
    }

    @Override
    public ReturnData<String> ativarUsuario(UsuarioDTO usuarioDTO) {
        var usuario = usuarioRepository.findByEmailAndCodigoAleatorio(usuarioDTO.getEmail(), usuarioDTO.getCodigoAleatorio());
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Email ou código informado é inválidio");
        } else {
            var tempoExpiracao = new Date().getTime() - usuario.get().getDataCadastro().getTime();

            if (tempoExpiracao < DEZ_MINUTOS_MILLISECUNDOS) {
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
                return new ReturnData<>(false, "Usuário não encontrado, por favor verifique os dados informados");
            } else {
                var codigoAleatorio = GerarCodigoAleatorio.gerarCodigo();

                var returnDataEmail = emailService.enviarEmail(false, usuarioDTO.getEmail(), codigoAleatorio, usuarioDTO.getNome());

                if (returnDataEmail.getSuccess()) {
                    usuario.get().setCodigoAleatorio(codigoAleatorio);
                    usuario.get().setDataCodigo(new Date());

                    usuarioRepository.saveAndFlush(usuario.get());

                    return new ReturnData<>(true, "Código para alterar senha enviado");
                }
                return returnDataEmail;
            }
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> alterarSenha(UsuarioDTO usuarioDTO) {
        try {
            var usuario = usuarioRepository.findByEmailAndCodigoAleatorio(usuarioDTO.getEmail(), usuarioDTO.getCodigoAleatorio());
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
            return new ReturnData<>(false, "Ocorreu um erro ao alterar senha", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
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
