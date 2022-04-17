package com.frfs.systetica.controller;

import com.frfs.systetica.dto.CidadeDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.CidadeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("cidade")
public class CidadeController {

    private final CidadeService cidadeService;

    @PostMapping("/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvarCidade(@Validated @RequestBody CidadeDTO cidadeDTO) {
        ReturnData<Object> result = cidadeService.salvarCidade(cidadeDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
