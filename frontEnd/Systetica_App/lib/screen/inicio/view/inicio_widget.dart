import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';
import 'package:systetica/screen/inicio/view/inicio_page.dart';
import 'package:systetica/screen/login/view/login/login_page.dart';
import 'package:systetica/style/app_colors..dart';

class InicioWidget extends State<InicioPage> with TickerProviderStateMixin {
  var myPageTransition = MyPageTransition();
  final List<Color> _colorList = [
    AppColors.blue1,
    AppColors.blue2,
    AppColors.blue3,
    AppColors.blue4,
    AppColors.blue5,
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color _bottomColor = AppColors.blue1;
  Color _topColor = AppColors.blue5;
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
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
                  tituloSystetica(),
                  imagemSalao(),
                  botaoLogin(),
                  botaoRegistrar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding tituloSystetica() {
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

  ImagensWidget imagemSalao() {
    return ImagensWidget(
      paddingLeft: 10,
      image: "cabelereiro-inicio.png",
      widthImagem: 320,
      paddingBottom: 20,
    );
  }

  BotaoWidget botaoLogin() {
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

  BotaoWidget botaoRegistrar() {
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
