import 'package:flutter/material.dart';

import '../../../../components/botoes/botao_widget.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/imagens_widget.dart';
import '../../../../components/input/campo_texto_widget.dart';
import '../../../../components/page_transition.dart';
import '../../../../components/text_autenticacoes_widget.dart';
import '../../../../model/validator/MultiValidatorUsuario.dart';
import '../../../../style/app_colors..dart';
import '../../cadastro_controller.dart';
import '../ativar_usuario/ativar_usuario_page.dart';
import 'cadastro_page.dart';

class CadastroWidget extends State<CadastroPage> {
  final CadastroController _controller = CadastroController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();

  var myPageTransition = MyPageTransition();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowIndicator();
            return false;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _controller.formKey,
              child: Column(
                children: [
                  _imageRegistro(paddinTop: _altura),
                  _textoAutenticacao(),
                  _inputNome(paddingHorizontal: _largura),
                  _inputTelefone(paddingHorizontal: _largura),
                  _inputEmail(paddingHorizontal: _largura),
                  _inputSenha(paddingHorizontal: _largura),
                  _inputConfirmaSenha(paddingHorizontal: _largura),
                  _botaoCadastrar(),
                  _botaoAtivar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imageRegistro({required double paddinTop}) {
    return ImagensWidget(
      paddingTop: paddinTop * 0.03,
      image: "registro.png",
      widthImagem: 180,
    );
  }

  TextAutenticacoesWidget _textoAutenticacao() {
    return TextAutenticacoesWidget(
      text: "Registrar-se",
    );
  }

  CampoTextoWidget _inputNome({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Nome completo",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 100,
      paddingTop: 14,
      isIconDate: true,
      icon: const Icon(
        Icons.face_rounded,
        color: Colors.black87,
      ),
      controller: _controller.nomeController,
      validator: _validatorUsuario.nomeValidator,
    );
  }

  CampoTextoWidget _inputEmail({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "E-mail",
      paddingHorizontal: paddingHorizontal * 0.08,
      paddingBottom: 0,
      maxLength: 80,
      paddingTop: 6,
      isIconDate: true,
      icon: const Icon(
        Icons.email,
        color: Colors.black87,
      ),
      controller: _controller.emailController,
      validator: _validatorUsuario.emailValidator,
    );
  }

  CampoTextoWidget _inputTelefone({required double paddingHorizontal}) {
    return CampoTextoWidget(
      labelText: "Telefone",
      paddingHorizontal: paddingHorizontal * 0.08,
      keyboardType: TextInputType.number,
      mask: "(##) #####-####",
      paddingBottom: 0,
      maxLength: 15,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        Icons.phone,
        color: Colors.black87,
      ),
      controller: _controller.telefoneController,
      validator: _validatorUsuario.telefoneValidator,
    );
  }

  CampoTextoWidget _inputSenha({required double paddingHorizontal}) {
    return CampoTextoWidget(
      paddingHorizontal: paddingHorizontal * 0.08,
      labelText: "Senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 6,
      controller: _controller.senhaController,
      validator: _validatorUsuario.senhaValidator,
    );
  }

  CampoTextoWidget _inputConfirmaSenha({required double paddingHorizontal}) {
    return CampoTextoWidget(
      paddingHorizontal: paddingHorizontal * 0.08,
      labelText: "Confirmar senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 6,
      controller: _controller.confirmaSenhaController,
      validator: _validatorUsuario.confirmaSenhaValidator,
    );
  }

  BotaoWidget _botaoCadastrar() {
    return BotaoWidget(
      paddingTop: 10,
      paddingBottom: 0,
      labelText: "CADASTRAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () async {
        await _controller.cadastrarUsuario(
          context,
          widget,
        );
      },
    );
  }

  BotaoWidget _botaoAtivar() {
    return BotaoWidget(
      paddingTop: 18,
      paddingBottom: 30,
      labelText: "ATIVAR USUÁRIO",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => Navigator.of(context).push(
        myPageTransition.pageTransition(
          child: const AtivarUsuarioPage(),
          childCurrent: widget,
        ),
      ),
    );
  }
}
