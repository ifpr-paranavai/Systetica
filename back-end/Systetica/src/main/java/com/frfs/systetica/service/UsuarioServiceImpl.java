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
    public ReturnData<String> salvarUsuario(UsuarioDTO usuarioDTO) {
        try {
            if (!Validate.validateCpf(usuarioDTO.getCpf().replace(".", "").replace("-", ""))) {
                return new ReturnData<>(false, "CPF inválido.", usuarioDTO.getCpf());
            }
            if (usuarioRepository.findByCpf(usuarioDTO.getCpf()).isPresent()) {
                return new ReturnData<>(false, "CPF já esta sendo utilizado.", "CPF " + usuarioDTO.getCpf() + " duplicado");
            }
            if (usuarioRepository.findByEmail(usuarioDTO.getEmail()).isPresent()) {
                return new ReturnData<>(false, "Email já esta sendo utilizado.", "Email " + usuarioDTO.getEmail() + " já esta em uso");
            }
            usuarioDTO.setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));

            usuarioDTO = roleService.adicionarRoleUsuario(usuarioDTO, "CLIENTE");

            var codigoAleatorio = GerarCodigoAleatorio.gerarCodigo();

            emailService.enviarEmail(usuarioDTO.getEmail(), codigoAleatorio);

            usuarioDTO.setDataCodigo(new Date());
            usuarioDTO.setCodigoAleatorio(codigoAleatorio);

            usuarioRepository.save(usuarioMapper.toEntity(usuarioDTO));
            return new ReturnData<>(true, "Usuário salvo com sucesso", "");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarUsuario(Long id) {
        var usuario = usuarioRepository.findById(id);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Usuário não encontrado.", "Não foi possível encontrar usuário pelo id " + id);
        }
        return new ReturnData<>(true, "", usuario);
    }

    @Override //todo verificar necessidade deste método
    public ReturnData<Object> buscarUsuarioPorEmail(String email) {
        var usuario = usuarioRepository.findByEmail(email);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Usuário não encontrado.", "Não foi possível encontrar usuário pelo email informado");
        }
        return new ReturnData<>(true, "", usuario.get());
    }

    @Override
    public ReturnData<Object> buscarTodosUsuario() {
        return new ReturnData<>(true, "", usuarioMapper.toListDto(usuarioRepository.findAll()));
    }

    @Override
    public ReturnData<Object> ativarUsuario(UsuarioDTO usuarioDTO) {
        var usuario = usuarioRepository.findByEmailAndCodigoAleatorio(usuarioDTO.getEmail(), usuarioDTO.getCodigoAleatorio());
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Erro", "Email ou código informado é inváldio");
        } else {

            var tempoExpiracao = new Date().getTime() - usuario.get().getDataCadastro().getTime();

            if (tempoExpiracao < DEZ_MINUTOS_MILLISECUNDOS) {
                usuario.get().setCodigoAleatorio(null);
                usuario.get().setDataCodigo(null);
                usuario.get().setUsuarioAtivo(true);
                usuarioRepository.save(usuario.get());
                return new ReturnData<>(true, "Sucesso", "Usuário foi ativado com sucesso");
            } else {
                return new ReturnData<>(false, "Erro", "Código foi expirado");
            }
        }
    }

    @Override
    public ReturnData<Object> gerarCodigo(UsuarioDTO usuarioDTO) {
        try {
            var usuario = usuarioRepository.findByEmailAndCpf(usuarioDTO.getEmail(), usuarioDTO.getCpf());
            if (usuario.isEmpty()) {
                return new ReturnData<>(false, "Erro", "Usuário não encontrado");
            } else {
                var codigoAleatorio = GerarCodigoAleatorio.gerarCodigo();

                emailService.enviarEmail(usuarioDTO.getEmail(), codigoAleatorio);

                usuario.get().setCodigoAleatorio(codigoAleatorio);
                usuario.get().setDataCodigo(new Date());

                usuarioRepository.save(usuario.get());

                return new ReturnData<>(true, "Sucesso", "Código para alterar senha enviado");
            }
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> alterarSenhaUsuario(UsuarioDTO usuarioDTO) {
        var usuario = usuarioRepository.findByEmailAndCodigoAleatorio(usuarioDTO.getEmail(), usuarioDTO.getCodigoAleatorio());
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Erro", "Email ou código informado é inváldio");
        } else {

            usuario.get().setCodigoAleatorio(null);
            usuario.get().setDataCodigo(null);
            usuario.get().setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));

            usuarioRepository.save(usuario.get());
            return new ReturnData<>(true, "Sucesso", "Senhar alterada com sucesso");
        }
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        var usuario = usuarioRepository.findByEmail(email);

        if (usuario.isEmpty()) {
            throw new UsernameNotFoundException("Usuário não encontrado");
        }

        // Todo
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
