import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/screen/servico/servico_controller.dart';
import 'package:systetica/screen/servico/view/servico_page.dart';

class ServicoWidget extends State<ServicoPage> {
  final ServicoController _controller = ServicoController();

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: FutureBuilder<Info?>(
          future: _controller.buscarServico(context: context, servico: ""),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else if (snapShot.hasData && snapShot.data!.success!) {
              return const Center(
                child: Text("data"),
              );
            } else {
              return _erroRequisicao(_largura);
            }
          },
        ),
      ),
    );
  }

  // Widgets de erro
  Center _erroRequisicao(double _largura) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagemErro(),
            _textoErro(_largura),
          ],
        ),
      ),
    );
  }

  ImagensWidget _imagemErro() {
    return ImagensWidget(
      paddingLeft: 0,
      image: "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro(double _largura) {
    return TextAutenticacoesWidget(
      paddingLeft: _largura * 0.10,
      paddingRight: _largura * 0.10,
      fontSize: 33,
      text: "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
