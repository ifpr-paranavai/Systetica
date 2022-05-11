package com.frfs.systetica.controller;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.CidadeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("cidade")
public class CidadeController {

    private final CidadeService cidadeService;

    @PostMapping("/buscar-todos")
    @ResponseBody
    public ResponseEntity<Object> buscarTodosUsuario(@RequestParam String search, Pageable page){
        ReturnData<Object> result;
        if(search.isBlank() || search.isEmpty()){
            result = cidadeService.buscarTodasCidades(page);
        } else {
            result = cidadeService.buscarTodasCidadesPaginado(search, page);
        }
        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
