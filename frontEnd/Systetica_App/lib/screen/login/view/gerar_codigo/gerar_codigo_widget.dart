import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorUsuario.dart';
import 'package:systetica/screen/login/login_controller.dart';
import 'package:systetica/screen/login/view/gerar_codigo/gerar_codigo_page.dart';

class GerarCodigoWidget extends State<GerarCodigoPage> {
  final LoginController _controller = LoginController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            IconArrowWidget(
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      imagemGerarCodigo(),
                      textoGerarCodigo(),
                      inputEmail(),
                      botaoGerarCodigo(),
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

  ImagensWidget imagemGerarCodigo() {
    return ImagensWidget(
      paddingLeft: 5,
      image: "gerar-codigo.png",
      widthImagem: 260,
    );
  }

  TextAutenticacoesWidget textoGerarCodigo() {
    return TextAutenticacoesWidget(
      text: "Gerar Código",
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


  BotaoWidget botaoGerarCodigo() {
    return BotaoWidget(
      paddingTop: 70,
      paddingBottom: 30,
      labelText: "Gerar Codigo",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => _controller.gerarCodigo(
        context,
        widget,
      ),
    );
  }
}
