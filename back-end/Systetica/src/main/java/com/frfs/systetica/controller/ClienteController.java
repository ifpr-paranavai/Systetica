package com.frfs.systetica.controller;

import com.frfs.systetica.dto.ClienteDTO;
import com.frfs.systetica.dto.RoleDTO;
import com.frfs.systetica.dto.RoleUserDTO;
import com.frfs.systetica.dto.UserDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.ClienteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("cliente")
public class ClienteController {

    private final ClienteService clienteService;

    @PostMapping("/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvarUsuario(@Validated @RequestBody ClienteDTO clienteDTO) {
        ReturnData<Object> result = clienteService.salvarCliente(clienteDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/salvar/role")
    @ResponseBody
    public ResponseEntity<Object> salvarRole(@Validated @RequestBody RoleDTO roleDTO) {
        ReturnData<Object> result = clienteService.salvarRole(roleDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/role/addtouser")
    public ResponseEntity<?> addRoleToUser(@ModelAttribute("role") RoleUserDTO roleDTO) {
        clienteService.addRoleToUser(roleDTO.getEmail(), roleDTO.getRoleName());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/buscar")
    @ResponseBody
    public ResponseEntity<Object> buscarUsuario(@Validated @RequestBody ClienteDTO clienteDTO) {
        ReturnData<Object> result = clienteService.buscarCLiente(clienteDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }


}
