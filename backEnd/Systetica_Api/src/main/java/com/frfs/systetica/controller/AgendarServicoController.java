package com.frfs.systetica.controller;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.AgendarServicoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("agendar-servico")
public class AgendarServicoController {

    private final AgendarServicoService agendarServicoService;

    @PostMapping("/buscar-todos-por-dia/{dia}")
    @ResponseBody
    public ResponseEntity<Object> buscarTodosPorDia(@PathVariable String dia) {
        ReturnData<Object> result = agendarServicoService.buscarTodosPorDia(dia);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
