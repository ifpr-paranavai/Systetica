package com.frfs.systetica.controller;

import com.frfs.systetica.service.AgendarServicoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@Slf4j
@RestController
@RequestMapping("agendar-servico")
public class AgendarServicoController {

    @Autowired
    private AgendarServicoService agendarServicoService;
}
