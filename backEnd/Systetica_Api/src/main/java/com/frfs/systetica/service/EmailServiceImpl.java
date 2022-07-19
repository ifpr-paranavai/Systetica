package com.frfs.systetica.service;

import com.frfs.systetica.dto.EmailDTO;
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

    private static final String MENSAGEM_TITULO_ATIVACAO = "Ativar usuário Systetica";
    private static final String MENSAGEM_BODY_ATIVACAO = "Código para ativar cadastro no aplicativo Systetica.";

    private static final String MENSAGEM_TITULO_ALTERAR = "Alterar senha Systetica";
    private static final String MENSAGEM_BODY_ALTERAR_SENHA = "Código para alterar senha no aplicativo Systetica.";

    private static final String MENSAGEM_VALIDADE_CODIGO = "\n\nCódigo válido por 10 minutos.\nCódigo: ";

    @Override
    public ReturnData<String> enviarEmail(boolean ativarUsuario, String email, Integer codigo, String nome) {
        try {
            EmailDTO emailDTO = montarMensagemEmail(ativarUsuario, codigo, nome);

            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("sistemas-tcc@tecnoif.com.br");
            message.setTo(email);
            message.setSubject(emailDTO.getMensagemSubject());
            message.setText(emailDTO.getMensagemText());

            javaMailSender.send(message);
            return new ReturnData<>(true, "", "Senha enviado com sucesso!");
        } catch (BusinessException busEx) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", busEx.getMessage());
        } catch (Exception ex) {
            return new ReturnData<>(false, "Ocorreu um erro ao enviar email.", ex.getMessage() + "\nMotivo: " + ex.getCause());
        }
    }

    private EmailDTO montarMensagemEmail(boolean ativarUsuario, Integer codigo, String nome) {
        EmailDTO emailDTO = new EmailDTO();

        if (ativarUsuario) {
            emailDTO.setMensagemSubject(MENSAGEM_TITULO_ATIVACAO);
            emailDTO.setMensagemText("Olá " + nome + "!\n\n" + MENSAGEM_BODY_ATIVACAO + MENSAGEM_VALIDADE_CODIGO + codigo + "\n\n\n Obrigado! \nSystetica");
        } else {
            emailDTO.setMensagemSubject(MENSAGEM_TITULO_ALTERAR);
            emailDTO.setMensagemText("Olá " + nome + "!\n\n" + MENSAGEM_BODY_ALTERAR_SENHA + MENSAGEM_VALIDADE_CODIGO + codigo + "\n\nObrigado! \nSystetica");
        }
        return emailDTO;
    }
}
