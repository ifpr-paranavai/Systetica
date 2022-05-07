import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/screen/autenticacao/login/view/login_page.dart';

class LoginWidget extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 260, bottom: 18),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35
                        ),
                      ),
                    ),
                    CampoTextoWidget(
                      labelText: "E-mail",
                      paddingBottom: 0,
                      maxLength: 50,
                      paddingTop: 10,
                    ),
                    CampoTextoWidget(
                      labelText: "Senha",
                      maxLength: 50,
                      isPassword: true,
                      paddingBottom: 0,
                      paddingTop: 5,
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 0,
                      paddingBottom: 0,
                      labelText: "LOGAR",
                      largura: 190,
                      corBotao: Colors.black,
                      corTexto: Colors.white,
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 18,
                      paddingBottom: 0,
                      labelText: "ESQUECI SENHA",
                      largura: 190,
                      corBotao: Colors.black,
                      corTexto: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}