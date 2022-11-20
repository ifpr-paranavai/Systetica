import 'package:flutter/material.dart';

import '../../../../components/botoes/botao_widget.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/imagens_widget.dart';
import '../../../../components/input/campo_texto_widget.dart';
import '../../../../components/text_autenticacoes_widget.dart';
import '../../../../model/validator/MultiValidatorUsuario.dart';
import '../../../../style/app_colors.dart';
import '../../login_controller.dart';
import 'alterar_senha_page.dart';

class AlterarSenhaWidget extends State<AlterarSenhaPage> {
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
                  _imagemAlterarSenha(paddinTop: altura * 0.03),
                  _textoAlterarSenha(),
                  _inputEmail(paddingHorizontal: largura * 0.08),
                  _inputCodigo(paddingHorizontal: largura * 0.08),
                  _inputNovaSenha(paddingHorizontal: largura * 0.08),
                  _inputConfirmaSenha(paddingHorizontal: largura * 0.08),
                  _botaoAlterarSenha(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imagemAlterarSenha({required double paddinTop}) {
    return ImagensWidget(
      paddingTop: paddinTop,
      image: "alterar-senha.png",
      widthImagem: 275,
    );
  }

  TextAutenticacoesWidget _textoAlterarSenha() {
    return TextAutenticacoesWidget(
      paddingTop: 10,
      paddingBottom: 2,
      text: "Alterar Senha",
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

  CampoTextoWidget _inputCodigo({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Códico",
      paddingHorizontal: paddingHorizontal,
      keyboardType: TextInputType.number,
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

  CampoTextoWidget _inputNovaSenha({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Nova senha",
      paddingHorizontal: paddingHorizontal,
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 10,
      controller: _controller.senhaController,
      validator: _validatorUsuario.senhaValidator,
    );
  }

  CampoTextoWidget _inputConfirmaSenha({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Confirmar senha",
      paddingHorizontal: paddingHorizontal,
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 10,
      controller: _controller.confirmaSenhaController,
      validator: _validatorUsuario.confirmaSenhaValidator,
    );
  }

  BotaoWidget _botaoAlterarSenha() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "ALTERAR SENHA",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => _controller.alterarSenha(
        context,
        widget,
      ),
    );
  }
}
