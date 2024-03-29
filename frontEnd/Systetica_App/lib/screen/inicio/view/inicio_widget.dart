import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/style/app_colors.dart';

import '../../../components/botoes/botao_widget.dart';
import '../../../components/imagens_widget.dart';
import '../../../components/page_transition.dart';
import '../../cadastro_usuario/view/cadastro/cadastro_page.dart';
import '../../login/view/login/login_page.dart';
import '../inicio_controller.dart';
import 'inicio_page.dart';

class InicioWidget extends State<InicioPage> with TickerProviderStateMixin {
  final InicioController _controller = InicioController();
  var myPageTransition = MyPageTransition();
  final List<Color> _colorList = [
    AppColors.blue1,
    AppColors.blue2,
    AppColors.blue3,
    AppColors.blue4,
    AppColors.blue5,
  ];
  int index = 0;
  Color _bottomColor = AppColors.blue1;
  Color _topColor = AppColors.blue5;

  @override
  void initState() {
    super.initState();
    _controller.verificarDirecionamentoUsuario(context);
    Timer(
      const Duration(microseconds: 0),
      () {
        setState(
          () {
            _bottomColor = AppColors.blue5;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(seconds: 2),
          onEnd: () {
            setState(
              () {
                index = index + 1;
                _bottomColor = _colorList[index % _colorList.length];
                _topColor = _colorList[(index + 1) % _colorList.length];
              },
            );
          },
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [_bottomColor, _topColor],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _tituloSystetica(),
                  _imagemSalao(),
                  _botaoLogin(),
                  _botaoRegistrar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _tituloSystetica() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Text(
          'Systetica',
          style: GoogleFonts.amaticSc(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ImagensWidget _imagemSalao() {
    return ImagensWidget(
      paddingLeft: 10,
      image: "cabelereiro-inicio.png",
      widthImagem: 320,
      paddingBottom: 20,
    );
  }

  BotaoWidget _botaoLogin() {
    return BotaoWidget(
      paddingTop: 35,
      paddingBottom: 18,
      labelText: "LOGIN",
      largura: 190,
      overlayColor: Colors.grey,
      corBotao: Colors.white,
      corTexto: Colors.black,
      onPressed: () => Navigator.of(context).push(
        myPageTransition.pageTransition(
          child: const LoginPage(),
          childCurrent: widget,
        ),
      ),
    );
  }

  BotaoWidget _botaoRegistrar() {
    return BotaoWidget(
      paddingTop: 0,
      paddingBottom: 30,
      labelText: "REGISTRAR",
      largura: 190,
      corBotao: Colors.black87.withOpacity(0.9),
      corTexto: Colors.white,
      onPressed: () => Navigator.of(context).push(
        myPageTransition.pageTransition(
          child: const CadastroPage(),
          childCurrent: widget,
        ),
      ),
    );
  }
}
