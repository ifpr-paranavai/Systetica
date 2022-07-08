import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';
import 'package:systetica/screen/inicio/view/inicio_page.dart';
import 'package:systetica/screen/login/view/login/login_page.dart';

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
                  padding: const EdgeInsets.only(top: 50),
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
              Image.asset(
                'assets/img/cabelereiro-inicio.png',
                fit: BoxFit.cover,
                width: 320,
              ),
              BotaoAcaoWidget(
                paddingTop: 35,
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
                corBotao: Colors.black87.withOpacity(0.9),
                corTexto: Colors.white,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CadastroPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
