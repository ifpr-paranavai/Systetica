import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/screen/autenticacao/cadastro/view/cadastrar/cadastro_page.dart';
import 'package:systetica/screen/autenticacao/login/login_controller.dart';
import 'package:systetica/screen/autenticacao/login/view/alterar_senha/gerar_codigo_page.dart';
import 'package:systetica/screen/autenticacao/login/view/login/login_page.dart';

class LoginWidget extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left_outlined, size: 35),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10, left: 35, top: MediaQuery.of(context).size.height / 5.5),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35
                  ),
                ),
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
                      corBotao: Colors.black,
                      corTexto: Colors.white,
                      onPressed: () =>
                          controller.login(context),
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 18,
                      paddingBottom: 0,
                      labelText: "ESQUECI SENHA",
                      largura: 190,
                      corBotao: Colors.black,
                      corTexto: Colors.white,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const GerarCodigoPage()),
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