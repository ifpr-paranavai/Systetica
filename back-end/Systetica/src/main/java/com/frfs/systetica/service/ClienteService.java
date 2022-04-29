package com.frfs.systetica.service;

import com.frfs.systetica.dto.ClienteDTO;
import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.UserDTO;
import com.frfs.systetica.dto.response.ReturnData;

public interface ClienteService {
    ReturnData<Object> salvarCliente(ClienteDTO clienteDTO);
    ReturnData<Object> salvarRole(RoleDTO roleDTO);
    ClienteDTO addRoleToUser(ClienteDTO clienteDTO, String roleName);
    ReturnData<Object> buscarCLiente(String email);
    ReturnData<Object> login(UserDTO userDTO);
}
