package com.frfs.systetica.controller;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("usuario")
public class UsuarioController {

    private final UsuarioService usuarioService;

    @PostMapping("/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvarUsuario(@Validated @RequestBody UsuarioDTO usuarioDTO) {
        ReturnData<String> result = usuarioService.salvarUsuario(usuarioDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Object> buscarUsuario(@PathVariable long id) {
        ReturnData<Object> result = usuarioService.buscarUsuario(id);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/buscar-todos")
    @ResponseBody
    public ResponseEntity<Object> buscarTodosUsuario(){
        ReturnData<Object> result = usuarioService.buscarTodosUsuario();

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
