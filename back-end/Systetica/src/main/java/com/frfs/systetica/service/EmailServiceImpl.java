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

    private static final String MENSAGEM_ATIVACAO_TITULO = "Código para criação de usuário Systetica";
    private static final String MENSAGEM_ATIVACAO = "Código para finalização de cadastro no aplicativo Systetica";
    private static final String MENSAGEM_ALTERAR_SENHA_TITULO = "Código para alterar senha do usuário Systetica";
    private static final String MENSAGEM_ALTERAR_SENHA = "Código para alteração de senha no aplicativo Systetica";

    @Override
    public ReturnData<String> enviarEmail(boolean ativaUsuario, String email, Integer codigo) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("projetoTeste45@gmail.com");
            message.setTo(email);
            message.setSubject(ativaUsuario ? MENSAGEM_ATIVACAO_TITULO : MENSAGEM_ALTERAR_SENHA_TITULO);
            message.setText(ativaUsuario ? MENSAGEM_ATIVACAO : MENSAGEM_ALTERAR_SENHA + "\n\nCódigo válido por 10 minutos.\nCódigo: " + codigo);

            javaMailSender.send(message);
            return new ReturnData<>(true, "", "Senha enviado com sucesso!");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }
}
