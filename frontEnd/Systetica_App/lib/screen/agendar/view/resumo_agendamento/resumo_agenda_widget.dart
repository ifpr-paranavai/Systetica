import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/screen/agendar/agendar_controller.dart';
import 'package:systetica/screen/agendar/component/agendar_componente.dart';
import 'package:systetica/screen/agendar/view/resumo_agendamento/resumo_agenda_page.dart';
import 'package:systetica/style/app_colors..dart';
import 'package:systetica/utils/util.dart';

class ResumoAgendaWidget extends State<ResumoAgendaPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendarController _controller = AgendarController();
  var myPageTransition = MyPageTransition();
  double _largura = 0;
  double _altura = 0;

  @override
  void initState() {
    super.initState();
    widget.agendamento;
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.011,
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
              altura: _altura,
              largura: _largura,
              text: "RESUMO DO AGENDAMENTO",
            ),
            _checkboxSelect(),
            _sizedBox(height: _altura * 0.08),
          ],
        ),
        AgendarComponente.botaoSelecinar(
          altura: _altura,
          largura: _largura,
          corBotao: Colors.black87.withOpacity(0.9),
          overlayCorBotao: AppColors.blue5,
          labelText: "AGENDAR",
          onPressed: () => _controller
              .agendarHorario(
                agendamento: widget.agendamento,
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
    int itemCount = widget.agendamento.servicosSelecionados.length;
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
                    nome: widget.agendamento.servicosSelecionados[index].nome!,
                    subTitulo: widget.agendamento.servicosSelecionados[index]
                            .tempoServico
                            .toString() +
                        ' min',
                    icon: CupertinoIcons.scissors_alt,
                    maxLines: widget.agendamento.servicosSelecionados.length,
                  );
                },
              ),
              _titulo(texto: "Barbeiro"),
              _listSelecao(
                nome: widget.agendamento.funcionario.nome!,
                terSubTituulo: false,
                icon: Icons.person,
              ),
              _titulo(texto: "Data e horário"),
              _listSelecao(
                nome: Util.dataEscrito(
                  widget.agendamento.horarioAgendamento.dataAgendamento!,
                ),
                subTitulo:
                    widget.agendamento.horarioAgendamento.horarioAgendamento!,
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
        left: 15,
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
        bottom: _largura * 0.05,
        left: 10,
        right: 10,
      ),
      width: _largura,
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
