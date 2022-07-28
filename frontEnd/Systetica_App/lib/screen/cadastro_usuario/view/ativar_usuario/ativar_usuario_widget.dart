import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorUsuario.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_controller.dart';
import 'package:systetica/screen/cadastro_usuario/view/ativar_usuario/ativar_usuario_page.dart';

class AtivarUsuarioWidget extends State<AtivarUsuarioPage> {
  final CadastroController _controller = CadastroController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            IconArrowWidget(
              paddingTop: 5,
              paddingBotton: 5,
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      imageAtivarUsuario(),
                      textAtivar(),
                      inputEmail(),
                      inputCodigo(),
                      botaoAtivaUsuario(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImagensWidget imageAtivarUsuario() {
    return ImagensWidget(
      paddingLeft: 10,
      image: "ativar-usuario.png",
      widthImagem: 220,
    );
  }

  TextAutenticacoesWidget textAtivar() {
    return TextAutenticacoesWidget(
      paddingTop: 10,
      paddingBottom: 2,
      text: "Ativar Usuário",
    );
  }

  CampoTextoWidget inputEmail() {
    return CampoTextoWidget(
      labelText: "E-mail",
      paddingBottom: 0,
      maxLength: 50,
      paddingTop: 10,
      isIconDate: true,
      icon: const Icon(
        Icons.email,
        color: Colors.black87,
      ),
      controller: _controller.emailController,
      validator: _validatorUsuario.emailValidator,
    );
  }

  CampoTextoWidget inputCodigo() {
    return CampoTextoWidget(
      labelText: "Códico",
      paddingBottom: 0,
      maxLength: 10,
      paddingTop: 10,
      isIconDate: true,
      icon: const Icon(
        Icons.code,
        color: Colors.black87,
      ),
      controller: _controller.codicoController,
      validator: _validatorUsuario.codigoValidator,
    );
  }

  BotaoWidget botaoAtivaUsuario() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "Ativar Usuário",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => _controller.ativiarUsuario(context),
    );
  }
}
