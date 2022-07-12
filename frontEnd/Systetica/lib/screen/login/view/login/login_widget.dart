import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/screen/login/login_controller.dart';
import 'package:systetica/screen/login/view/gerar_codigo/gerar_codigo_page.dart';
import 'package:systetica/screen/login/view/login/login_page.dart';

class LoginWidget extends State<LoginPage> {
  LoginController controller = LoginController();
  var myPageTransition = MyPageTransition();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            IconArrowWidget(
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formKey,
                  child: Column(
                    children: [
                      imagemLogin(),
                      textoLogin(),
                      inputEmail(),
                      inputSenha(),
                      botaoLogin(),
                      botaoEsqueciSenha(),
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

  ImagensWidget imagemLogin() {
    return ImagensWidget(
      paddingLeft: 10,
      image: "login.png",
      widthImagem: 280,
    );
  }

  TextAutenticacoesWidget textoLogin() {
    return TextAutenticacoesWidget(
      text: "Login",
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
      controller: controller.emailController,
      validator: controller.emailValidator,
    );
  }

  CampoTextoWidget inputSenha() {
    return CampoTextoWidget(
      labelText: "Senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 5,
      controller: controller.senhaController,
      validator: controller.senhaValidator,
    );
  }

  BotaoAcaoWidget botaoLogin() {
    return BotaoAcaoWidget(
      paddingTop: 10,
      paddingBottom: 0,
      labelText: "LOGIN",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () async {
        await controller.login(context, widget);
      },
    );
  }

  BotaoAcaoWidget botaoEsqueciSenha() {
    return BotaoAcaoWidget(
      paddingTop: 18,
      paddingBottom: 0,
      labelText: "ESQUECI SENHA",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => Navigator.of(context).push(
        myPageTransition.pageTransition(
          child: const GerarCodigoPage(),
          childCurrent: widget,
        ),
      ),
    );
  }
}
