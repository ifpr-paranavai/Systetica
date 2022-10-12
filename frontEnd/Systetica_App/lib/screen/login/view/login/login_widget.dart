import 'package:flutter/material.dart';

import '../../../../components/botoes/botao_widget.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/imagens_widget.dart';
import '../../../../components/input/campo_texto_widget.dart';
import '../../../../components/page_transition.dart';
import '../../../../components/text_autenticacoes_widget.dart';
import '../../../../model/validator/MultiValidatorUsuario.dart';
import '../../../../style/app_colors..dart';
import '../../login_controller.dart';
import '../gerar_codigo/gerar_codigo_page.dart';
import 'login_page.dart';

class LoginWidget extends State<LoginPage> {
  LoginController controller = LoginController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();
  var myPageTransition = MyPageTransition();

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Visibility(
          visible: widget.inicioApp,
          child: IconArrowWidget(
            paddingTop: _altura * 0.01,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.formKey,
              child: Column(
                children: [
                  _imagemLogin(paddinTop: _altura * 0.03),
                  _textoLogin(),
                  _inputEmail(paddingHorizontal: _largura * 0.08),
                  _inputSenha(paddingHorizontal: _largura * 0.08),
                  _botaoLogin(),
                  _botaoEsqueciSenha(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imagemLogin({required double paddinTop}) {
    return ImagensWidget(
      paddingTop: paddinTop,
      paddingLeft: 0,
      image: "login.png",
      widthImagem: 260,
    );
  }

  TextAutenticacoesWidget _textoLogin() {
    return TextAutenticacoesWidget(
      text: "Login",
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
      controller: controller.emailController,
      validator: _validatorUsuario.emailValidator,
    );
  }

  CampoTextoWidget _inputSenha({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Senha",
      paddingHorizontal: paddingHorizontal,
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 5,
      controller: controller.senhaController,
      validator: _validatorUsuario.senhaValidator,
    );
  }

  BotaoWidget _botaoLogin() {
    return BotaoWidget(
      paddingTop: 10,
      paddingBottom: 0,
      labelText: "LOGIN",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () async {
        await controller.login(context, widget);
      },
    );
  }

  BotaoWidget _botaoEsqueciSenha() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "ESQUECI SENHA",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => Navigator.of(context).push(
        myPageTransition.pageTransition(
          child: GerarCodigoPage(),
          childCurrent: widget,
        ),
      ),
    );
  }
}
