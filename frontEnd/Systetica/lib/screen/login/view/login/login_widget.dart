import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/screen/login/login_controller.dart';
import 'package:systetica/screen/login/view/gerar_codigo/gerar_codigo_page.dart';
import 'package:systetica/screen/login/view/login/login_page.dart';

class LoginWidget extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();
  var myPageTransition = MyPageTransition();

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
                image: "login.png",
                widthImagem: 280,
              ),
              TextAutenticacoesWidget(
                text: "Login",
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
                      labelText: "Senha",
                      maxLength: 16,
                      isPassword: true,
                      paddingBottom: 0,
                      paddingTop: 5,
                      controller: controller.senhaController,
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 0,
                      paddingBottom: 0,
                      labelText: "LOGIN",
                      largura: 190,
                      corBotao: Colors.black87.withOpacity(0.9),
                      corTexto: Colors.white,
                      onPressed: () => controller.login(
                        context,
                        widget,
                      ),
                    ),
                    BotaoAcaoWidget(
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
