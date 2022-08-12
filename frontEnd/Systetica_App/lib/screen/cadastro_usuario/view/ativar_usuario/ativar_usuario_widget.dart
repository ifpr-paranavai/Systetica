import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/input/campo_texto_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/validator/MultiValidatorUsuario.dart';
import 'package:systetica/screen/cadastro_usuario/cadastro_controller.dart';
import 'package:systetica/screen/cadastro_usuario/view/ativar_usuario/ativar_usuario_page.dart';
import 'package:systetica/screen/login/view/gerar_codigo/gerar_codigo_page.dart';

class AtivarUsuarioWidget extends State<AtivarUsuarioPage> {
  final CadastroController _controller = CadastroController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();
  var myPageTransition = MyPageTransition();

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _controller.formKey,
            child: Column(
              children: [
                _imageAtivarUsuario(paddinTop: altura * 0.03),
                _textAtivar(),
                _inputEmail(paddingHorizontal: largura * 0.08),
                _inputCodigo(paddingHorizontal: largura * 0.08),
                _botaoAtivaUsuario(),
                _botaoReenviarCodigo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imageAtivarUsuario({required double paddinTop}) {
    return ImagensWidget(
      paddingTop: paddinTop,
      paddingLeft: 10,
      image: "ativar-usuario.png",
      widthImagem: 220,
    );
  }

  TextAutenticacoesWidget _textAtivar() {
    return TextAutenticacoesWidget(
      paddingTop: 10,
      paddingBottom: 2,
      text: "Ativar Usuário",
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
      controller: _controller.codicoController,
      validator: _validatorUsuario.codigoValidator,
      icon: const Icon(
        Icons.code,
        color: Colors.black87,
      ),
    );
  }

  BotaoWidget _botaoAtivaUsuario() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 0,
      labelText: "ATIVAR USUÁRIO",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => _controller.ativiarUsuario(context),
    );
  }

  BotaoWidget _botaoReenviarCodigo() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "REENVIAR CÓDIGO",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => Navigator.of(context).push(
        myPageTransition.pageTransition(
          child: GerarCodigoPage(reenviarCodigo: true),
          childCurrent: widget,
        ),
      ),
    );
  }
}
