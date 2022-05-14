import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/screen/autenticacao/cadastro/cadastro_controller.dart';
import 'package:systetica/screen/autenticacao/cadastro/view/ativar_usuario/ativar_usuario_page.dart';

class AtivarUsuarioWidget extends State<AtivarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  CadastroController controller = CadastroController();

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
                  "Ativar Usuário",
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
                    BotaoAcaoWidget(
                      paddingTop: 18,
                      paddingBottom: 0,
                      labelText: "Ativar Usuário",
                      largura: 190,
                      corBotao: Colors.black87.withOpacity(0.9),
                      corTexto: Colors.white,
                      onPressed: () => controller.ativiarUsuario(context),
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