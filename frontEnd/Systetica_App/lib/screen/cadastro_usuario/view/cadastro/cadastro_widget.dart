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
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';

class CadastroWidget extends State<CadastroPage> {
  final CadastroController _controller = CadastroController();
  final MultiValidatorUsuario _validatorUsuario = MultiValidatorUsuario();

  var myPageTransition = MyPageTransition();

  late ScrollController _scrollController;
  late ScrollController _scrollControllerDropDown;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollControllerDropDown = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerDropDown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double largura = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconArrowWidget(
        paddingTop: altura * 0.01,
        onPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _controller.formKey,
            child: Column(
              children: [
                _imageRegistro(paddinTop: altura * 0.03),
                _textoAutenticacao(),
                _inputNome(paddingHorizontal: largura * 0.08),
                _inputTelefone(paddingHorizontal: largura * 0.08),
                _inputEmail(paddingHorizontal: largura * 0.08),
                _inputSenha(paddingHorizontal: largura * 0.08),
                _inputConfirmaSenha(paddingHorizontal: largura * 0.08),
                _botaoCadastrar(),
                _botaoAtivar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImagensWidget _imageRegistro({required double paddinTop}) {
    return ImagensWidget(
      paddingTop: paddinTop,
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
      paddingHorizontal: paddingHorizontal,
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
      paddingHorizontal: paddingHorizontal,
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
      paddingHorizontal: paddingHorizontal,
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
      controller: _controller.telefone,
      validator: _validatorUsuario.telefoneValidator,
    );
  }

  CampoTextoWidget _inputSenha({required double paddingHorizontal}) {
    return CampoTextoWidget(
      paddingHorizontal: paddingHorizontal,
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
      paddingHorizontal: paddingHorizontal,
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
