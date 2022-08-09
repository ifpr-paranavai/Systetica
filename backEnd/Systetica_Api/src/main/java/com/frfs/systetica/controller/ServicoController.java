package com.frfs.systetica.controller;

import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.ServicoService;
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
@RequestMapping("servico")
public class ServicoController {

    private final ServicoService servicoService;


    @PostMapping(value = "/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvar(@Validated @RequestBody ServicoDTO servicoDTO) {
        ReturnData<String> result = servicoService.salvar(servicoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/atualizar")
    @ResponseBody
    public ResponseEntity<Object> atualizar(@Validated @RequestBody ServicoDTO servicoDTO) {
        ReturnData<String> result = servicoService.atualizar(servicoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/buscar-todos")
    @ResponseBody
    public ResponseEntity<Object> buscarCidades(@RequestParam String search, Pageable page){
        ReturnData<Object> result;
        if(search.isBlank() || search.isEmpty()){
            result = servicoService.buscarTodos(page);
        } else {
            result = servicoService.buscarTodosPaginado(search, page);
        }
        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
