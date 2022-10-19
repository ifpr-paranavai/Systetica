import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import '../../../../components/horario_component.dart';
import '../../../../components/loading/loading_animation.dart';
import '../../../../style/app_colors..dart';
import '../../agendamento_controller.dart';
import '../detalhes_agendamento/detalhes_agendamento_page.dart';
import 'agendamento_page.dart';

class AgendamentolWidget extends State<AgendamentoPage> {
  final AgendamentoController _controller = AgendamentoController();

  bool agendamentoVazio = false;
  bool loading = true;
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    _controller.agendamentos = [];
    dateTime = DateTime.now();
    _buscarTodosAgendamentoPorDia(dateTime!);
  }

  Future<void> _buscarTodosAgendamentoPorDia(DateTime data) async {
    await _controller
        .buscarTodosAgendamentoPorDia(
          dataSelecionada: data,
        )
        .then(
          (value) => setState(
            () {
              _controller.agendamentos = value!.object;
              _controller.agendamentos.isEmpty
                  ? agendamentoVazio = true
                  : agendamentoVazio = false;
              loading = false;
              dateTime = data;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    _controller.largura = MediaQuery.of(context).size.width;
    _controller.altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
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
              HorarioComponent().titulo(
                largura: _controller.largura * 0.1,
                altura: _controller.altura * 0.019,
              ),
              HorarioComponent().cardHorario(children: [
                _calendarTimeLine(),
                loading
                    ? const Expanded(child: LoadingAnimation())
                    : _agendamentoDoDia(),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calendarTimeLine() {
    return CalendarTimeline(
      initialDate: dateTime!,
      firstDate: DateTime(
        2022,
        01,
        01,
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
      onDateSelected: (dataSelecionada) {
        loading = true;
        _buscarTodosAgendamentoPorDia(
          dataSelecionada,
        );
      },
    );
  }

  Widget _agendamentoDoDia() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          top: agendamentoVazio == true ? 0 : 30,
          bottom: 0,
          left: 20,
          right: 20,
        ),
        child: agendamentoVazio
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HorarioComponent().imagemErro(altura: _controller.altura),
                    HorarioComponent().textoErro(),
                  ],
                ),
              )
            : GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 1.7, // TODO - teste em outros dispositivos
                mainAxisSpacing: 18,
                crossAxisSpacing: 0,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: _listaDeHorarios(),
              ),
      ),
    );
  }

  List<Widget> _listaDeHorarios() {
    return List.generate(
      _controller.agendamentos.length,
      (index) {
        return _cardInfoUsuario(index);
      },
    );
  }

  Widget _cardInfoUsuario(int index) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 0.15,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: HorarioComponent().cardInformacoes(
          largura: _controller.largura * 0.74,
          nome: _controller.agendamentos[index].cliente!.nome!,
          dataAgendamento: _controller.agendamentos[index].dataAgendamento!,
          horarioAgendamento:
              _controller.agendamentos[index].horarioAgendamento!,
          situacao: _controller.agendamentos[index].situacao!.name,
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(
              _controller.myPageTransition.pageTransition(
                child: DetalhesAgendamentoPage(
                    agendamento: _controller.agendamentos[index]),
                childCurrent: widget,
                buttoToTop: true,
              ),
            )
            .then(
              (value) => setState(() {
                _buscarTodosAgendamentoPorDia(dateTime!);
              }),
            );
      },
    );
  }
}
