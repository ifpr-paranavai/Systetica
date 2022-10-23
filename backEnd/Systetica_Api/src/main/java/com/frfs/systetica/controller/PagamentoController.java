package com.frfs.systetica.controller;

import com.frfs.systetica.dto.PagamentoProdutoDTO;
import com.frfs.systetica.dto.PagamentoServicoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.entity.PagamentoProduto;
import com.frfs.systetica.service.PagamentoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("pagamento")
public class PagamentoController {

    private final PagamentoService pagamentoService;

    @PostMapping(value = "/servico")
    @ResponseBody
    public ResponseEntity<Object> pagamentoServico(@Validated @RequestBody PagamentoServicoDTO pagamentoServicoDTO) {
        ReturnData<String> result = pagamentoService.pagamentoServico(pagamentoServicoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(value = "/produto")
    @ResponseBody
    public ResponseEntity<Object> pagamentoProduto(@Validated @RequestBody PagamentoProdutoDTO pagamentoProdutoDTO) {
        ReturnData<String> result = pagamentoService.pagamentoProduto(pagamentoProdutoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}