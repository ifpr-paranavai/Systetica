import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';
import 'package:systetica/screen/inicio/view/inicio_page.dart';
import 'package:systetica/screen/login/view/login/login_page.dart';

class InicioWidget extends State<InicioPage> {
  var myPageTransition = MyPageTransition();

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
                Colors.black87,
                Colors.blue,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      'Systetica',
                      style: GoogleFonts.amaticSc(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              ImagensWidget(
                paddingLeft: 10,
                image: "cabelereiro-inicio.png",
                widthImagem: 320,
                paddingBottom: 20,
              ),
              BotaoAcaoWidget(
                paddingTop: 35,
                paddingBottom: 18,
                labelText: "LOGIN",
                largura: 190,
                corBotao: Colors.white,
                corTexto: Colors.black,
                onPressed: () => Navigator.of(context).push(
                  myPageTransition.pageTransition(
                    child: const LoginPage(),
                    childCurrent: widget,
                  ),
                ),
              ),
              BotaoAcaoWidget(
                paddingTop: 0,
                paddingBottom: 30,
                labelText: "REGISTRAR",
                largura: 190,
                corBotao: Colors.black87.withOpacity(0.9),
                corTexto: Colors.white,
                onPressed: () => Navigator.of(context).push(
                  myPageTransition.pageTransition(
                    child: const CadastroPage(),
                    childCurrent: widget,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
