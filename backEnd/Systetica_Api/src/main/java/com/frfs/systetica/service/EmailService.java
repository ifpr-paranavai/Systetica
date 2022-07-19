package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;

public interface EmailService {
    ReturnData<String> enviarEmail(boolean ativarUsuario, String email, Integer codigo, String nome);
}
