import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/screen/login/login_controller.dart';
import 'package:systetica/screen/login/view/alterar_senha/alterar_senha_page.dart';

class AlterarSenhaWidget extends State<AlterarSenhaPage> {
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconArrowWidget(
                onPressed: () => Navigator.pop(context),
              ),
              ImagensWidget(
                paddingLeft: 10,
                image: "alterar-senha.png",
                widthImagem: 300,
              ),
              TextAutenticacoesWidget(
                paddingTop: 10,
                paddingBottom: 2,
                text: "Alterar Senha",
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CampoTextoWidget(
                      labelText: "E-mail",
                      paddingBottom: 0,
                      maxLength: 50,
                      paddingTop: 10,
                      isIconDate: true,
                      icon: const Icon(
                        Icons.email,
                        color: Colors.black87,
                      ),
                      controller: controller.emailController,
                    ),
                    CampoTextoWidget(
                      labelText: "Códico",
                      paddingBottom: 0,
                      maxLength: 10,
                      paddingTop: 10,
                      isIconDate: true,
                      icon: const Icon(
                        Icons.code,
                        color: Colors.black87,
                      ),
                      controller: controller.codicoController,
                    ),
                    CampoTextoWidget(
                      controller: controller.senhaController,
                      labelText: "Nova senha",
                      maxLength: 16,
                      isPassword: true,
                      paddingBottom: 0,
                      paddingTop: 5,
                    ),
                    CampoTextoWidget(
                      controller: controller.confirmaSenhaController,
                      labelText: "Confirmar senha",
                      maxLength: 16,
                      isPassword: true,
                      paddingBottom: 0,
                      paddingTop: 5,
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 0,
                      paddingBottom: 0,
                      labelText: "Alterar Senha",
                      largura: 190,
                      corBotao: Colors.black87.withOpacity(0.9),
                      corTexto: Colors.white,
                      onPressed: () => controller.alterarSenha(
                        context,
                        widget,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
