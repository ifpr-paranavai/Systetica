package com.frfs.systetica.service;

import com.frfs.systetica.dto.ClienteDTO;
import com.frfs.systetica.dto.UserDTO;
import com.frfs.systetica.dto.response.ReturnData;

public interface ClienteService {

    ReturnData<Object> salvarCliente(ClienteDTO clienteDTO);

    ReturnData<Object> login(UserDTO userDTO);
}
