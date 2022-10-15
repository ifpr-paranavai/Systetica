package com.frfs.systetica.controller;

import com.frfs.systetica.dto.DadosAgendamentoDTO;
import com.frfs.systetica.dto.AgendamentoDTO;
import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.service.AgendamentoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("agendamento")
public class AgendamentoController {

    private final AgendamentoService agendarServicoService;

    @PostMapping("/buscar-todos-por-dia")
    @ResponseBody
    public ResponseEntity<Object> buscarTodosAgendamentoPorDia(@RequestParam String dia, String email) {
        ReturnData<Object> result;
        if (email == null) {
            result = agendarServicoService.buscarTodosAgendamentoPorDia(dia);
        } else {
            result = agendarServicoService.buscarTodosAgendamentoPorDiaUsuario(dia, email);
        }
        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(value = "/salvar")
    @ResponseBody
    public ResponseEntity<Object> salvar(@Validated @RequestBody DadosAgendamentoDTO dadosAgendamentoDTO) {
        ReturnData<String> result = agendarServicoService.salvar(dadosAgendamentoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(value = "/cancelar")
    @ResponseBody
    public ResponseEntity<Object> cancelar(@Validated @RequestBody AgendamentoDTO agendamentoDTO) {
        ReturnData<String> result = agendarServicoService.cancelar(agendamentoDTO);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/buscar-todos-por-dia-agendados")
    @ResponseBody
    public ResponseEntity<Object> buscarTodosAgendamentoPorDiaAgendados(@RequestParam String dia) {
        ReturnData<Object> result = agendarServicoService.buscarTodosAgendamentoPorDiaAgendados(dia);

        return new ResponseEntity<>(result, result.getSuccess() ? HttpStatus.OK : HttpStatus.INTERNAL_SERVER_ERROR);
    }
}