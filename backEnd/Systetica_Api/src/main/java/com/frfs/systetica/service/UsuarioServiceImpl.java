package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Role;
import com.frfs.systetica.entity.Usuario;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.RoleRepository;
import com.frfs.systetica.repository.UsuarioRepository;
import com.frfs.systetica.utils.Constantes;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
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
    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;
    private final RoleRepository roleRepository;
    private final EmailService emailService;
    private final CodigoAleatorioService codigoAleatorioService;
    private final FileBase64Service fileBase64Service;

    @Override
    public ReturnData<String> salvar(UsuarioDTO usuarioDTO) {
        try {
            if (usuarioRepository.findByEmail(usuarioDTO.getEmail()).isPresent()) {
                return new ReturnData<>(false, "Email já esta sendo utilizado.");
            }
            var codigoAleatorio = codigoAleatorioService.gerarCodigo();

            var returnDataEmail = emailService.enviarEmail(usuarioDTO.getEmail(), codigoAleatorio,
                    usuarioDTO.getNome());

            if (!returnDataEmail.getSuccess()) {
                return returnDataEmail;
            }

            usuarioDTO.setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));
            usuarioDTO.setRoles(roleService.buscaRolePorNome("CLIENTE"));
            usuarioDTO.setDataCadastro(new Date());
            usuarioDTO.setDataCodigo(new Date());
            usuarioDTO.setCodigoAleatorio(codigoAleatorio);

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
        Optional<Usuario> usuario = usuarioRepository.findById(id);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Usuário não encontrado.",
                    "Não foi possível encontrar usuário pelo id " + id);
        }
        return new ReturnData<>(true, "", usuarioMapper.toDto(usuario.get()));
    }

    @Override
    public ReturnData<Object> buscarPorEmail(String email, boolean buscarParaToken) {
        var usuario = usuarioRepository.findByEmail(email);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Usuário não encontrado.",
                    "Não foi possível encontrar usuário pelo email" + email);
        }
        if (buscarParaToken) {
            return new ReturnData<>(true, "", usuario.get());
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
            return new ReturnData<>(false, "Email ou código informado inválido");
        }
        var tempoExpiracao = new Date().getTime() - usuario.get().getDataCadastro().getTime();

        if (tempoExpiracao < Constantes.DEZ_MINUTOS_MILLISECUNDOS_CODIGO) {
            usuario.get().setCodigoAleatorio(null);
            usuario.get().setDataCodigo(null);
            usuario.get().setUsuarioAtivo(true);
            usuarioRepository.saveAndFlush(usuario.get());
            return new ReturnData<>(true, "Usuário ativado com sucesso");
        }
        return new ReturnData<>(false, "Código expirado");
    }

    @Override
    public ReturnData<String> gerarCodigoAleatorio(String email) {
        var usuario = usuarioRepository.findByEmail(email);

        if (usuario.isEmpty()) {
            return new ReturnData<>(false,
                    "Usuário não encontrado, por favor verifique email informado");
        }
        var codigoAleatorio = codigoAleatorioService.gerarCodigo();

        var returnDataEmail = emailService.enviarEmail(email, codigoAleatorio,
                usuario.get().getNome());

        if (!returnDataEmail.getSuccess()) {
            return returnDataEmail;
        }
        usuario.get().setCodigoAleatorio(codigoAleatorio);
        usuario.get().setDataCodigo(new Date());

        usuarioRepository.saveAndFlush(usuario.get());
        return new ReturnData<>(true, "Código para alterar senha enviado");

    }

    @Override
    public ReturnData<String> alterarSenha(UsuarioDTO usuarioDTO) {
        try {
            var usuario = usuarioRepository.findByEmailAndCodigoAleatorio(usuarioDTO.getEmail(),
                    usuarioDTO.getCodigoAleatorio());

            if (usuario.isEmpty()) {
                return new ReturnData<>(false, "Email ou código são inválidos");
            }
            usuario.get().setCodigoAleatorio(null);
            usuario.get().setDataCodigo(null);
            usuario.get().setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));

            usuarioRepository.saveAndFlush(usuario.get());
            return new ReturnData<>(true, "Senha alterada com sucesso");
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao alterar senha",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<String> atualizar(UsuarioDTO usuarioDTO) {
        try {
            var returnDataConverteBase64 = fileBase64Service.converteFileBase64(usuarioDTO.getImagemBase64());
            if (!returnDataConverteBase64.getSuccess()) {
                return returnDataConverteBase64;
            }

            Optional<Usuario> usuarioBanco = usuarioRepository.findById(usuarioDTO.getId());

            usuarioBanco.get().setNome(usuarioDTO.getNome());
            usuarioBanco.get().setTelefone(usuarioDTO.getTelefone());
            usuarioBanco.get().setImagemBase64(returnDataConverteBase64.getMessage());

            usuarioRepository.saveAndFlush(usuarioBanco.get());

            return new ReturnData<>(true, "Usuário atualizado com sucesso.");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao atualizar dados",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> buscarPorNomeEmail(String search, Pageable page) {
        return new ReturnData<>(true, "", usuarioMapper.toListDto(usuarioRepository.findAllFields(search, page).getContent()));
    }

    @Override
    public ReturnData<String> concederPermissaoFuncionairo(UsuarioDTO usuarioDTO) {
        try {
            Collection<Role> roles = new ArrayList<>();
            var usuario = usuarioRepository.findByEmail(usuarioDTO.getEmail());

            Role role = roleRepository.findByName("FUNCIONARIO");

            roles.add(role);

            usuario.get().setRoles(roles);

            usuarioRepository.saveAndFlush(usuario.get());
            return new ReturnData<>(true, "Permissão concedida com sucesso.");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao conceder permissão", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao conceder permissão",
                    ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<Usuario> usuario = usuarioRepository.findByEmail(email);

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