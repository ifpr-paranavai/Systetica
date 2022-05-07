import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/screen/autenticacao/cadastro/view/cadastro_page.dart';

class CadastroWidget extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

      ),
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
                    // Padding(
                    //   padding: EdgeInsets.only(right: 210, bottom: 18),
                    //   child: Text(
                    //     "Cadastro",
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 20
                    //     ),
                    //   ),
                    // ),
                    CampoTextoWidget(
                      labelText: "Nome",
                      paddingBottom: 0,
                      maxLength: 100,
                      paddingTop: 3,
                    ),
                    CampoTextoWidget(
                      labelText: "CPF",
                      keyboardType: TextInputType.number,
                      mask: "###.###.###-##",
                      paddingBottom: 0,
                      maxLength: 14,
                      paddingTop: 3,
                    ),
                    CampoTextoWidget(
                      labelText: "Data Nascimento",
                      paddingBottom: 0,
                      maxLength: 100,
                      paddingTop: 3,
                    ),
                    CampoTextoWidget(
                      labelText: "Celular",
                      mask: "(##) #####-####",
                      paddingBottom: 0,
                      maxLength: 15,
                      paddingTop: 3,
                    ),
                    CampoTextoWidget(
                      labelText: "E-mail",
                      paddingBottom: 0,
                      maxLength: 50,
                      paddingTop: 3,
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
                      labelText: "CADASTRAR",
                      largura: 190,
                      corBotao: Colors.black,
                      corTexto: Colors.white,
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 18,
                      paddingBottom: 0,
                      labelText: "VOLTAR",
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