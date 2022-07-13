package com.frfs.systetica.utils;

import java.util.Random;

public class GerarCodigoAleatorio {
    public static int gerarCodigo() {
        Random gerador = new Random();
        return gerador.nextInt(100000) + 100000;
    }
}
