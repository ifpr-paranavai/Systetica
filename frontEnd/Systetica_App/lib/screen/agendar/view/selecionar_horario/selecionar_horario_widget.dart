import 'package:flutter/material.dart';
import 'package:systetica/components/botoes/botao_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/screen/agendar/component/agendar_componente.dart';
import 'package:systetica/screen/agendar/view/selecionar_horario/selecionar_horario_page.dart';

class SelecionarHorarioWidget extends State<SelecionarHorarioPage> {
  double _largura = 0;
  double _altura = 0;
  bool loading = true;
  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  bool selecionadoUmDia = false;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

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
        body: loading ? const LoadingAnimation() : _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Column(
          children: [
            AgendarComponente.info(
              altura: _altura,
              largura: _largura,
              text: "SELECIONE O DIA",
            ),
            _checkboxSelect(),
          ],
        ),
        _botaoSelecinarDia()
      ],
    );
  }

  Widget _checkboxSelect() {
    return AgendarComponente.containerGeral(listView: Text(""));
  }

  Widget _botaoSelecinarDia() {
    return Container(
      padding: EdgeInsets.only(
        bottom: _altura * 0.03,
      ),
      alignment: Alignment.bottomCenter,
      child: BotaoWidget(
        paddingTop: 10,
        paddingBottom: 0,
        labelText: "CONTINUAR",
        largura: _largura * 0.6,
        corBotao: corBotao,
        corTexto: Colors.white,
        overlayColor: overlayCorBotao,
        onPressed: () => {},
        // onPressed: () => {
        //   selecionadoUmDia == true
        //       ? Navigator.of(context).push(
        //     myPageTransition.pageTransition(
        //       child: SelecionarHorarioPage(
        //         agendamento: widget.agendamento,
        //       ),
        //       childCurrent: widget,
        //     ),
        //   )
        //       : null,
        // },
      ),
    );
  }
}
