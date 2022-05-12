import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/screen/autenticacao/cadastro/view/cadastro_page.dart';
import 'package:systetica/screen/autenticacao/view/inicio_page.dart';
import 'package:systetica/screen/autenticacao/login/view/login_page.dart';

class InicioWidget extends State<InicioPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Center(
                    child: Text(
                      'Systetica',
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              BotaoAcaoWidget(
                paddingTop: 20,
                paddingBottom: 18,
                labelText: "LOGIN",
                largura: 190,
                corBotao: Colors.white,
                corTexto: Colors.black,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
              ),
              BotaoAcaoWidget(
                paddingTop: 0,
                paddingBottom: 30,
                labelText: "REGISTRAR",
                largura: 190,
                corBotao: Colors.black,
                corTexto: Colors.white,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastroPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
