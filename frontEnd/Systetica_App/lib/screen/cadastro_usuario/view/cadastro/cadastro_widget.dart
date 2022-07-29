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
                controller: _scrollController,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      imageRegistro(),
                      textoAutenticacao(),
                      inputNome(),
                      inputTelefone(),
                      inputEmail(),
                      inputSenha(),
                      inputConfirmaSenha(),
                      botaoCadastrar(),
                      botaoAtivar(),
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

  ImagensWidget imageRegistro() {
    return ImagensWidget(
      image: "registro.png",
      widthImagem: 180,
    );
  }

  TextAutenticacoesWidget textoAutenticacao() {
    return TextAutenticacoesWidget(
      text: "Registrar-se",
    );
  }

  CampoTextoWidget inputNome() {
    return CampoTextoWidget(
      labelText: "Nome completo",
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

  CampoTextoWidget inputEmail() {
    return CampoTextoWidget(
      labelText: "E-mail",
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

  CampoTextoWidget inputTelefone() {
    return CampoTextoWidget(
      labelText: "Telefone",
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

  CampoTextoWidget inputSenha() {
    return CampoTextoWidget(
      labelText: "Senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 6,
      controller: _controller.senhaController,
      validator: _validatorUsuario.senhaValidator,
    );
  }

  CampoTextoWidget inputConfirmaSenha() {
    return CampoTextoWidget(
      labelText: "Confirmar senha",
      maxLength: 16,
      isPassword: true,
      paddingBottom: 0,
      paddingTop: 6,
      controller: _controller.confirmaSenhaController,
      validator: _validatorUsuario.confirmaSenhaValidator,
    );
  }

  BotaoWidget botaoCadastrar() {
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

  BotaoWidget botaoAtivar() {
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
