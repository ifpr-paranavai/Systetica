package com.frfs.systetica.service;

import com.frfs.systetica.dto.ClienteDTO;
import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.UserDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.Cliente;

public interface ClienteService {
    ReturnData<Object> salvarCliente(ClienteDTO clienteDTO);
    ReturnData<Object> salvarRole(RoleDTO roleDTO);
    void adicionarRoleToUsuario(Cliente cliente);
    ReturnData<Object> buscarCLiente(String email);
    ReturnData<Object> login(UserDTO userDTO);
}
