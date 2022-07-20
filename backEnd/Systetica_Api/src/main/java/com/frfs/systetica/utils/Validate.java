package com.frfs.systetica.utils;

import br.com.caelum.stella.ValidationMessage;
import br.com.caelum.stella.validation.CPFValidator;

import java.util.List;

public class Validate {
    public static boolean validateCpf(String cpf) {
        List<ValidationMessage> erros = new CPFValidator().invalidMessagesFor(cpf
                .replace(".", "")
                .replace("-", ""));

        return erros.size() <= 0;
    }
}
