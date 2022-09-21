import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/screen/agendar/view/selecionar_horario/selecionar_horario_page.dart';

class SelecionarHorarioWidget extends State<SelecionarHorarioPage> {
  double _largura = 0;
  double _altura = 0;

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.011,
          onPressed: () => Navigator.pop(context),
        ),
        body: const LoadingAnimation(),
      ),
    );
  }
}
