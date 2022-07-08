import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/campos_texto/campo_texto_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_controller.dart';
import 'package:systetica/screen/cadastro_usuario/view/ativar_usuario/ativar_usuario_page.dart';

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
            children: [
              IconArrowWidget(
                onPressed: () => Navigator.pop(context),
              ),
              ImagensWidget(
                paddingLeft: 10,
                image: "ativar-usuario.png",
                widthImagem: 220,
              ),
              TextAutenticacoesWidget(
                paddingTop: 10,
                paddingBottom: 2,
                text: "Ativar Usuário",
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
