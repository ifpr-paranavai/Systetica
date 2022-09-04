package com.frfs.systetica.controller;

import com.frfs.systetica.dto.EmpresaDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.EmpresaService;
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
@RequestMapping("empresa")
public class EmpresaController {

    private final EmpresaService empresaService;

    @PostMapping(value = "/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvar(@Validated @RequestBody EmpresaDTO empresaDTO) {
        ReturnData<String> result = empresaService.salvar(empresaDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PutMapping(value = "/atualizar")
    @ResponseBody
    public ResponseEntity<Object> atualizar(@Validated @RequestBody EmpresaDTO empresaDTO) {
        ReturnData<String> result = empresaService.atualizar(empresaDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "email/{email}")
    @ResponseBody
    public ResponseEntity<Object> buscarPorEmailAdministrador(@PathVariable String email) {
        ReturnData<Object> result = empresaService.buscarPorEmailAdministrador(email);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/buscar-todos")
    @ResponseBody
    public ResponseEntity<Object> buscarTodos(@RequestParam String search, Pageable page){
        ReturnData<Object> result;
        if(search.isBlank() || search.isEmpty()){
            result = empresaService.buscarTodasEmpresas(page);
        } else {
            result = empresaService.buscarTodasEmpresasPaginado(search, page);
        }
        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
