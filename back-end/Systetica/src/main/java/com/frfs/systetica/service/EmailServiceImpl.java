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

    @Override
    public ReturnData<String> enviarEmail(String email, Integer codigo) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("projetoTeste45@gmail.com");
            message.setTo(email);
            message.setSubject("Código para criação de usuário Systetica");
            message.setText("Código para finalização de cadastro no aplicativo Systetica.\n\nCódigo válido por 10 minutos.\nCódigo: " + codigo);

            javaMailSender.send(message);
            return new ReturnData<>(true, "", "Senha enviado com sucesso!");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }
}
