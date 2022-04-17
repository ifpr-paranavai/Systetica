package com.frfs.systetica.controller;

import com.frfs.systetica.dto.ClienteDTO;
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

    private final  ClienteService clienteService;

    @PostMapping("/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvarUsuario(@Validated @RequestBody ClienteDTO clienteDTO) {
        ReturnData<Object> result = clienteService.salvarCliente(clienteDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<Object> login(@ModelAttribute("user")UserDTO userDTO) {
        ReturnData<Object> result = clienteService.login(userDTO);

        return new ResponseEntity<>(result.getSuccess() ? HttpStatus.OK : HttpStatus.UNAUTHORIZED);
    }
}
