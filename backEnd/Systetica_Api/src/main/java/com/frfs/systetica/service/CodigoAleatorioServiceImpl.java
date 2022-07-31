package com.frfs.systetica.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
@RequiredArgsConstructor
@Slf4j
public class CodigoAleatorioServiceImpl implements CodigoAleatorioService {


    @Override
    public int gerarCodigo() {
        Random gerador = new Random();
        return gerador.nextInt(100000) + 100000;
    }
}
