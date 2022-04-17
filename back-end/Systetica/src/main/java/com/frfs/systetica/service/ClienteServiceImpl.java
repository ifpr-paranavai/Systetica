package com.frfs.systetica.service;

import com.frfs.systetica.dto.ClienteDTO;
import com.frfs.systetica.dto.UserDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.exception.BusinessException;
import com.frfs.systetica.mapper.CidadeMapper;
import com.frfs.systetica.mapper.ClienteMapper;
import com.frfs.systetica.repository.ClienteRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class ClienteServiceImpl implements ClienteService {

    private final ClienteRepository clienteRepository;
    private final ClienteMapper clienteMapper;
    private final PasswordEncoder passwordEncoder;

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
}
