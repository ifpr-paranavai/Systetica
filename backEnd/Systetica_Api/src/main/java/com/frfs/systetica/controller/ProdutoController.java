package com.frfs.systetica.controller;

import com.frfs.systetica.dto.ProdutoDTO;
import com.frfs.systetica.dto.ServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.ProdutoService;
import com.frfs.systetica.service.ServicoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("produto")
public class ProdutoController {
    private final ProdutoService produtoService;


    @PostMapping(value = "/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvar(@Validated @RequestBody ProdutoDTO produtoDTO) {
        ReturnData<String> result = produtoService.salvar(produtoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/atualizar")
    @ResponseBody
    public ResponseEntity<Object> atualizar(@Validated @RequestBody ProdutoDTO produtoDTO) {
        ReturnData<String> result = produtoService.atualizar(produtoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping("/buscar-todos")
    @ResponseBody
    public ResponseEntity<Object> buscarTodos(@RequestParam String search, Pageable page, String email) {
        ReturnData<Object> result;
        if (search.isBlank() || search.isEmpty()) {
            result = produtoService.buscarTodos(page, email);
        } else {
            result = produtoService.buscarTodosPaginado(search, page, email);
        }
        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping("/buscar-por-empresa/{id}")
    @ResponseBody
    public ResponseEntity<Object> buscarTodosPorIdEmpresa(@PathVariable long id) {
        ReturnData<Object> result = produtoService.buscarTodosPorIdEmpresa(id);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
