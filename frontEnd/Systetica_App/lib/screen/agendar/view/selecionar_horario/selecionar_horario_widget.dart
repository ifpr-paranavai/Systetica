// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/model/HorarioAgendamento.dart';
import 'package:systetica/screen/agendar/agendar_controller.dart';
import 'package:systetica/screen/agendar/component/agendar_componente.dart';
import 'package:systetica/screen/agendar/view/selecionar_horario/selecionar_horario_page.dart';
import 'package:systetica/style/app_colors..dart';

class SelecionarHorarioWidget extends State<SelecionarHorarioPage> {
  final AgendarController _controller = AgendarController();

  DateTime? dateTime;
  double _largura = 0;
  double _altura = 0;
  bool loading = true;
  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  List<HorarioAgendamento> horariosAgendamento = [];
  bool horarioSelecionado = false;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    buscarTodosAgendamentoDisponiveis(dateTime!);
    loading = false;
  }

  Future<void> buscarTodosAgendamentoDisponiveis(DateTime data) async {
    await _controller
        .buscarTodosAgendamentoPorDia(
          dataAgendamento: DateFormat('yyyy-MM-dd').format(data),
          empresa: widget.agendamento.empresa,
        )
        .then(
          (value) => setState(
            () {
              horariosAgendamento = value!.object!;
              loading = false;
              dateTime = data;
            },
          ),
        );
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
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: Stack(
        children: [
          Column(
            children: [
              AgendarComponente.info(
                altura: _altura,
                largura: _largura,
                text: "SELECIONE O DIA",
              ),
              _checkboxSelect(), //TODO - Loading
            ],
          ),
          AgendarComponente.botaoSelecinar(
            altura: _altura,
            largura: _largura,
            corBotao: corBotao,
            overlayCorBotao: overlayCorBotao,
            onPressed: () => {},
          ),
        ],
      ),
    );
  }

  Widget _checkboxSelect() {
    return AgendarComponente.containerGeral(
      widget: Column(
        children: [
          _calendarTimeLine(),
          _horariosLivres(),
        ],
      ),
    );
  }

  Widget _calendarTimeLine() {
    return CalendarTimeline(
      initialDate: dateTime!,
      firstDate: DateTime(
        dateTime!.year - 1,
        dateTime!.month,
        dateTime!.day,
      ),
      lastDate: DateTime(
        dateTime!.year + 1,
        dateTime!.month,
        dateTime!.day,
      ),
      leftMargin: 20,
      monthColor: Colors.black,
      dayColor: AppColors.bluePrincipal,
      activeDayColor: Colors.white,
      activeBackgroundDayColor: AppColors.redPrincipal,
      dotsColor: Colors.white,
      onDateSelected: (dataSelecionada) async => {
        buscarTodosAgendamentoDisponiveis(
          dataSelecionada,
        )
      },
    );
  }

  Widget _horariosLivres() {
    var quantHorarios = horariosAgendamento.length;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 70,
          left: 20,
          right: 20,
        ),
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          mainAxisSpacing: 18,
          crossAxisSpacing: 30,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: List.generate(
            quantHorarios,
            (index) {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: horariosAgendamento[index].selecionado
                        ? AppColors.redPrincipal
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      horariosAgendamento[index].horario!,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: horariosAgendamento[index].selecionado
                            ? Colors.white
                            : AppColors.bluePrincipal,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  desmarcarHorario();
                  marcarhorario(index);
                  selecionarHorario(index);
                  ativarDesativarBotao();
                  setState(() {});
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void desmarcarHorario() {
    horariosAgendamento.forEach((horario) {
      horario.selecionado == true ? horario.selecionado = false : null;
    });
  }

  void marcarhorario(int index) {
    horariosAgendamento[index].selecionado == true
        ? horariosAgendamento[index].selecionado = false
        : horariosAgendamento[index].selecionado = true;
  }

  void selecionarHorario(int index) {
    horariosAgendamento[index].selecionado == true
        ? widget.agendamento.horarioAgendamento = horariosAgendamento[index]
        : widget.agendamento.horarioAgendamento = HorarioAgendamento();
  }

  void ativarDesativarBotao() {
    if (widget.agendamento.horarioAgendamento.horario == null) {
      horarioSelecionado = false;
      corBotao = Colors.grey.withOpacity(0.9);
      overlayCorBotao = Colors.transparent;
    } else {
      horarioSelecionado = true;
      corBotao = Colors.black87.withOpacity(0.9);
      overlayCorBotao = AppColors.blue5;
    }
  }
}
