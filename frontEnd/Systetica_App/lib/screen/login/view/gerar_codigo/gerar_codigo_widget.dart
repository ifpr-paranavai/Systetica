import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_acao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/screen/login/login_controller.dart';
import 'package:systetica/screen/login/view/gerar_codigo/gerar_codigo_page.dart';

class GerarCodigoWidget extends State<GerarCodigoPage> {
  LoginController controller = LoginController();

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
                  key: controller.formKey,
                  child: Column(
                    children: [
                      imagemGerarCodigo(),
                      textoGerarCodigo(),
                      inputEmail(),
                      inputCpf(),
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
      paddingLeft: 10,
      image: "gerar-codigo.png",
      widthImagem: 300,
    );
  }

  TextAutenticacoesWidget textoGerarCodigo() {
    return TextAutenticacoesWidget(
      text: "Gerar Código",
      fontSize: 42,
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
      controller: controller.emailController,
      validator: controller.emailValidator,
    );
  }

  CampoTextoWidget inputCpf() {
    return CampoTextoWidget(
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
      controller: controller.cpfController,
      validator: controller.cpfValidator,
    );
  }

  BotaoAcaoWidget botaoGerarCodigo() {
    return BotaoAcaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "Gerar Codigo",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => controller.gerarCodigo(
        context,
        widget,
      ),
    );
  }
}
