package com.frfs.systetica.service;

import com.frfs.systetica.dto.ClienteDTO;
import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.UserDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Cliente;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.ClienteMapper;
import com.frfs.systetica.mapper.RoleMapper;
import com.frfs.systetica.repository.ClienteRepository;
import com.frfs.systetica.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class ClienteServiceImpl implements ClienteService, UserDetailsService {

    private final ClienteRepository clienteRepository;
    private final RoleRepository roleRepository;
    private final ClienteMapper clienteMapper;
    private final RoleMapper roleMapper;
    private final PasswordEncoder passwordEncoder;

    @Override
    public ReturnData<Object> login(UserDTO userDTO) {
        try {
            var cliente = clienteRepository.findByEmail(userDTO.getEmail());

            if (cliente.isEmpty()) {
                return new ReturnData<>(false, "Cliente não encontrado.");
            }

            if (passwordEncoder.matches(userDTO.getPassword(), cliente.get().getPassword())) {
                return new ReturnData<>(true, "Sucesso.");
            } else {
                return new ReturnData<>(false, "Erro.");
            }
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao realizar login.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao realizar login.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> salvarCliente(ClienteDTO clienteDTO) {
        try {
            clienteDTO.setPassword(passwordEncoder.encode(clienteDTO.getPassword()));
            var cliente = clienteRepository.save(clienteMapper.toEntity(clienteDTO));
            var clienteSalvo = clienteMapper.toDto(cliente);

            return new ReturnData<>(true, "Cliente salvo com sucesso.", clienteSalvo);
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um cliente.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public ReturnData<Object> salvarRole(RoleDTO roleDTO) {
        try {
            var role = roleRepository.save(roleMapper.toEntity(roleDTO));
            var roleSalva = roleMapper.toDto(role);
            return new ReturnData<>(true, "Role salvo com sucesso.", roleSalva);
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um role.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao salvar um role.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    @Override
    public void adicionarRoleToUsuario(Cliente cliente) {
//        var c = cliente.getRoles();
//        c.forEach(role -> {
//
//        });
//
//        Role role = roleRepository.findByName(cliente.getRoles().get(0).get);
//        cliente.get().getRoles().add(role);
    }

    @Override
    public ReturnData<Object> buscarCLiente(String email) {
        return new ReturnData<>(true, "", clienteRepository.findByEmail(email).get());
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        var cliente = clienteRepository.findByEmail(email);

        if (cliente.isEmpty()) {
            throw new UsernameNotFoundException("Usuário não encontrado");
        }

        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
        cliente.get().getRoles().forEach(role ->
                authorities.add(new SimpleGrantedAuthority(role.getName()))
        );
        return new User(cliente.get().getEmail(), cliente.get().getPassword(), authorities);
    }
}
