import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/screen/agendar/view/resumo_agendamento/resumo_agenda_page.dart';

class ResumoAgendaWidget extends State<ResumoAgendaPage> {
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
        body: Text("Olá mundo"),
      ),
    );
  }
}
