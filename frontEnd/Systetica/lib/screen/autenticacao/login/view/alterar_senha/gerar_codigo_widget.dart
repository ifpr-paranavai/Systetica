import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/screen/autenticacao/login/login_controller.dart';
import 'package:systetica/screen/autenticacao/login/view/alterar_senha/gerar_codigo_page.dart';

class GerarCodigoWidget extends State<GerarCodigoPage> {
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
                  icon:
                  const Icon(Icons.keyboard_arrow_left_outlined, size: 35),
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Image.network(
                  'https://ouch-cdn2.icons8.com/i8QlhCZepdjYRpi0bHZYEOQirRki53QQf_4N5OTnBxY/rs:fit:456:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvODUy/LzQyNzdiOGEzLTJm/N2YtNDg1My1hNzhh/LTcyNzI3NmQ1YzNk/Yi5zdmc.png',
                  fit: BoxFit.cover,
                  width: 210,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                  left: 35,
                  top: 0,
                ),
                child: Text(
                  "Gerar Código",
                  style: TextStyle(fontSize: 32),
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
                      isIconDate: true,
                      icon: const Icon(
                        Icons.email,
                        color: Colors.black87,
                      ),
                      controller: controller.emailController,
                    ),
                    CampoTextoWidget(
                      controller: controller.cpfController,
                      labelText: "CPF",
                      keyboardType: TextInputType.number,
                      mask: "###.###.###-##",
                      paddingBottom: 0,
                      maxLength: 14,
                      paddingTop: 5,
                      isIconDate: true,
                      icon: const Icon(
                        Icons.people,
                        color: Colors.black87,
                      ),
                    ),
                    BotaoAcaoWidget(
                      paddingTop: 0,
                      paddingBottom: 0,
                      labelText: "Gerar Codigo",
                      largura: 190,
                      corBotao: Colors.black87.withOpacity(0.9),
                      corTexto: Colors.white,
                      onPressed: () => controller.gerarCodigo(context),
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