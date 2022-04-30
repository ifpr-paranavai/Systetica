package com.frfs.systetica.service;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.UsuarioMapper;
import com.frfs.systetica.repository.UsuarioRepository;
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

    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;
    private final PasswordEncoder passwordEncoder;
    private final RoleService roleService;

    @Override
    public ReturnData<Object> salvarUsuario(UsuarioDTO usuarioDTO) {
        try {
            if (!Validate.validateCpf(usuarioDTO.getCpf())) {
                return new ReturnData<>(false, "CPF inválido.", usuarioDTO.getCpf());
            }
            if (usuarioRepository.findByCpf(usuarioDTO.getCpf()).isPresent()) {
                return new ReturnData<>(false, "CPF já esta sendo utilizado.", "CPF " + usuarioDTO.getCpf() + " duplicado");
            }
            if (usuarioRepository.findByEmail(usuarioDTO.getEmail()).isPresent()) {
                return new ReturnData<>(false, "Email já esta sendo utilizado.", "Email " + usuarioDTO.getEmail() + " já esta em uso");
            }
            usuarioDTO.setPassword(passwordEncoder.encode(usuarioDTO.getPassword()));

            usuarioDTO.setDataCadastro(new Date());

            usuarioDTO = roleService.adicionarRoleUsuario(usuarioDTO, "CLIENTE");

            var usuario = usuarioRepository.save(usuarioMapper.toEntity(usuarioDTO));

            return new ReturnData<>(true, "Cliente salvo com sucesso.", usuarioMapper.toDto(usuario));
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente.", ex.getMessage() + "\nMotivo: " + ex.getCause());
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

    @Override
    public ReturnData<Object> buscarUsuarioPorEmail(String email) {
        var usuario = usuarioRepository.findByEmail(email);
        if (usuario.isEmpty()) {
            return new ReturnData<>(false, "Usuário não encontrado.", "Não foi possível encontrar usuário pelo email informado");
        }
        return new ReturnData<>(true, "", usuario);
    }

    @Override
    public ReturnData<Object> buscarTodosUsuario() {
        return new ReturnData<>(true, "", usuarioRepository.findAll());
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        var usuario = usuarioRepository.findByEmail(email);

        if (usuario.isEmpty()) {
            throw new UsernameNotFoundException("Usuário não encontrado");
        }

        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();

        usuario.get().getRoles().forEach(role ->
                authorities.add(new SimpleGrantedAuthority(role.getName()))
        );
        return new User(usuario.get().getEmail(), usuario.get().getPassword(), authorities);
    }
}
