package com.frfs.systetica.controller;

import com.frfs.systetica.dto.UsuarioDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
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

    @PostMapping(value = "/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvar(@Validated @RequestBody UsuarioDTO usuarioDTO) {
        ReturnData<String> result = usuarioService.salvar(usuarioDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/atualizar")
    @ResponseBody
    public ResponseEntity<Object> atualizar(@Validated @RequestBody UsuarioDTO usuarioDTO) {
        ReturnData<String> result = usuarioService.atualizar(usuarioDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/{id}")
    @ResponseBody
    public ResponseEntity<Object> buscarPorId(@PathVariable long id) {
        ReturnData<Object> result = usuarioService.buscarPorId(id);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "email/{email}")
    @ResponseBody
    public ResponseEntity<Object> buscarPorEmail(@PathVariable String email) {
        ReturnData<Object> result = usuarioService.buscarPorEmail(email, false);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/ativar")
    @ResponseBody
    public ResponseEntity<Object> ativar(@Validated @RequestBody UsuarioDTO usuarioDTO) {
        ReturnData<String> result = usuarioService.ativar(usuarioDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/gerar-codigo")
    @ResponseBody
    public ResponseEntity<Object> gerarCodigo(@RequestParam String email) {
        ReturnData<String> result = usuarioService.gerarCodigoAleatorio(email);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/alterar-senha")
    @ResponseBody
    public ResponseEntity<Object> alterarSenha(@Validated @RequestBody UsuarioDTO usuarioDTO) {
        ReturnData<String> result = usuarioService.alterarSenha(usuarioDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/buscar-nome-email")
    @ResponseBody
    public ResponseEntity<Object> buscarPorNomeEmail(@RequestParam String search, Pageable page) {
        ReturnData<Object> result = usuarioService.buscarPorNomeEmail(search, page);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/permissao-funcionario")
    @ResponseBody
    public ResponseEntity<Object> concederPermissaoFuncionairo(@Validated @RequestBody UsuarioDTO usuarioDTO) {
        ReturnData<String> result = usuarioService.concederPermissaoFuncionairo(usuarioDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }


}
