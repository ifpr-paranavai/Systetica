import 'package:flutter/material.dart';

import '../../../../components/botoes/botao_widget.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/imagens_widget.dart';
import '../../../../components/input/campo_texto_widget.dart';
import '../../../../components/text_autenticacoes_widget.dart';
import '../../../../model/validator/MultiValidatorUsuario.dart';
import '../../../../style/app_colors..dart';
import '../../login_controller.dart';
import 'gerar_codigo_page.dart';

class GerarCodigoWidget extends State<GerarCodigoPage> {
  final LoginController _controller = LoginController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();


  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _controller.formKey,
              child: Column(
                children: [
                  _imagemGerarCodigo(paddinTop: altura * 0.03),
                  _textoGerarCodigo(),
                  _inputEmail(paddingHorizontal: largura * 0.08),
                  _botaoGerarCodigo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imagemGerarCodigo({required double paddinTop}) {
    return ImagensWidget(
      paddingTop: paddinTop,
      paddingLeft: 5,
      image: "gerar-codigo.png",
      widthImagem: 260,
    );
  }

  TextAutenticacoesWidget _textoGerarCodigo() {
    return TextAutenticacoesWidget(
      text: "Gerar Código",
    );
  }

  CampoTextoWidget _inputEmail({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "E-mail",
      paddingHorizontal: paddingHorizontal,
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

  BotaoWidget _botaoGerarCodigo() {
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
        widget.reenviarCodigo
      ),
    );
  }
}
