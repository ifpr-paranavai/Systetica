package com.frfs.systetica.service;

import com.frfs.systetica.dto.response.ReturnData;
import com.frfs.systetica.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender javaMailSender;

    private static final String MENSAGEM_TITULO = "Código Systetica";

    private static final String MENSAGEM_BODY = """
            Primeiramente gostaríamos de agradecer pela utilização do aplicativo Systetica.

            Estamos enviado este email com o código aleatório criado pelo aplicativo.
            
            """;

    private static final String MENSAGEM_VALIDADE_CODIGO = """
            Atenção!!!
            Código é válido por apenas 10 minutos.
            Código:\040""";

    @Override
    public ReturnData<String> enviarEmail(String email, Integer codigo, String nome) {
        try {

            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("franciel@tecnoif.com.br");
            message.setTo(email);
            message.setSubject(MENSAGEM_TITULO);
            message.setText("Olá " + nome + "!\n\n" + MENSAGEM_BODY + MENSAGEM_VALIDADE_CODIGO + codigo + "\n\nObrigado! \nSystetica");

            javaMailSender.send(message);
            return new ReturnData<>(true, "", "Código enviado com sucesso!");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }
}
