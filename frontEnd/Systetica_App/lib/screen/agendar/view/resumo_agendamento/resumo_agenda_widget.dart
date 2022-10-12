import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/page_transition.dart';
import '../../../../style/app_colors..dart';
import '../../../../utils/util.dart';
import '../../agendar_controller.dart';
import '../../component/agendar_componente.dart';
import 'resumo_agenda_page.dart';

class ResumoAgendaWidget extends State<ResumoAgendaPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  var myPageTransition = MyPageTransition();

  @override
  void initState() {
    super.initState();
    widget.dadosAgendamento;
  }

  @override
  Widget build(BuildContext context) {
    _controller.largura = MediaQuery.of(context).size.width;
    _controller.altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _controller.altura * 0.011,
          onPressed: () => Navigator.pop(context),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        Column(
          children: [
            AgendarComponente.info(
              altura: _controller.altura,
              largura: _controller.largura,
              text: "RESUMO DO AGENDAMENTO",
            ),
            _checkboxSelect(),
            _sizedBox(height: _controller.altura * 0.08),
          ],
        ),
        AgendarComponente.botaoSelecinar(
          altura: _controller.altura,
          largura: _controller.largura,
          corBotao: Colors.black87.withOpacity(0.9),
          overlayCorBotao: AppColors.blue5,
          labelText: "AGENDAR",
          onPressed: () => _controller
              .agendarHorario(
                dadosAgendamento: widget.dadosAgendamento,
                context: context,
              )
              .then(
                (value) => setState(
                  () {},
                ),
              ),
        ),
      ],
    );
  }

  Widget _checkboxSelect() {
    int itemCount = widget.dadosAgendamento.servicosSelecionados.length;
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: AgendarComponente.containerGeral(
        widget: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              _titulo(
                texto: itemCount > 1 ? "Serviços" : "Serviço",
              ),
              ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return _listSelecao(
                    nome: widget
                        .dadosAgendamento.servicosSelecionados[index].nome!,
                    subTitulo: widget.dadosAgendamento
                            .servicosSelecionados[index].tempoServico
                            .toString() +
                        ' min',
                    icon: CupertinoIcons.scissors_alt,
                    maxLines:
                        widget.dadosAgendamento.servicosSelecionados.length,
                  );
                },
              ),
              _titulo(texto: "Barbeiro"),
              _listSelecao(
                nome: widget.dadosAgendamento.funcionario.nome!,
                terSubTituulo: false,
                icon: Icons.person,
              ),
              _titulo(texto: "Data e horário"),
              _listSelecao(
                nome: Util.dataEscrito(
                  widget.dadosAgendamento.horarioAgendamento.dataAgendamento!,
                ),
                subTitulo: widget
                    .dadosAgendamento.horarioAgendamento.horarioAgendamento!,
                icon: Icons.calendar_month,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titulo({
    required String texto,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        bottom: 8,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        texto,
        maxLines: 1,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _listSelecao({
    required String nome,
    String subTitulo = '',
    required IconData icon,
    int maxLines = 1,
    bool terSubTituulo = true,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: _controller.largura * 0.05,
        left: 20,
        right: 20,
      ),
      width: _controller.largura,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 5,
          top: 13,
          bottom: 13,
        ),
        child: Row(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Icon(
                  icon,
                  color: AppColors.bluePrincipal,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                info(
                  maxLines: maxLines,
                  informacao: nome,
                ),
                terSubTituulo == true
                    ? info(
                        maxLines: maxLines,
                        informacao: subTitulo,
                        fontSize: 15.5,
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget info({
    required String informacao,
    int maxLines = 1,
    double fontSize = 18,
  }) {
    return Text(
      informacao,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
