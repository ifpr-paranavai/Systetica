import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorUsuario.dart';
import 'package:systetica/screen/login/login_controller.dart';
import 'package:systetica/screen/login/view/alterar_senha/alterar_senha_page.dart';

class AlterarSenhaWidget extends State<AlterarSenhaPage> {
  final LoginController _controller = LoginController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            IconArrowWidget(
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      imagemAlterarSenha(),
                      textoAlterarSenha(),
                      inputEmail(),
                      inputCodigo(),
                      inputNovaSenha(),
                      inputConfirmaSenha(),
                      botaoAlterarSenha(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImagensWidget imagemAlterarSenha() {
    return ImagensWidget(
      image: "alterar-senha.png",
      widthImagem: 275,
    );
  }

  TextAutenticacoesWidget textoAlterarSenha() {
    return TextAutenticacoesWidget(
      paddingTop: 10,
      paddingBottom: 2,
      text: "Alterar Senha",
    );
  }

  CampoTextoWidget inputEmail() {
    return CampoTextoWidget(
      labelText: "E-mail",
      paddingBottom: 0,
      maxLength: 50,
      paddingTop: 10,
      isIconDate: true,
      icon: const Icon(
        Icons.email,
        color: Colors.black87,
      ),
      controller: _controller.emailController,
      validator: _validatorUsuario.emailValidator,
    );
  }

  CampoTextoWidget inputCodigo() {
    return CampoTextoWidget(
      labelText: "Códico",
      paddingBottom: 0,
      maxLength: 10,
      paddingTop: 10,
      isIconDate: true,
      icon: const Icon(
        Icons.code,
        color: Colors.black87,
      ),
      controller: _controller.codicoController,
      validator: _validatorUsuario.codigoValidator,
    );
  }

  CampoTextoWidget inputNovaSenha() {
    return CampoTextoWidget(
      labelText: "Nova senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 10,
      controller: _controller.senhaController,
      validator: _validatorUsuario.senhaValidator,
    );
  }

  CampoTextoWidget inputConfirmaSenha() {
    return CampoTextoWidget(
      labelText: "Confirmar senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 10,
      controller: _controller.confirmaSenhaController,
      validator: _validatorUsuario.confirmaSenhaValidator,
    );
  }

  BotaoWidget botaoAlterarSenha() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "Alterar Senha",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => _controller.alterarSenha(
        context,
        widget,
      ),
    );
  }
}
