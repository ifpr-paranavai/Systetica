import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import '../../../../components/imagens_widget.dart';
import '../../../../components/item_list.dart';
import '../../../../components/loading/loading_animation.dart';
import '../../../../components/text_autenticacoes_widget.dart';
import '../../../../style/app_colors..dart';
import '../../../../utils/util.dart';
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
              Container(
                padding: EdgeInsets.only(
                  left: _controller.largura * 0.1,
                  top: _controller.altura * 0.019,
                ),
                color: AppColors.branco,
                child: TextAutenticacoesWidget(
                  text: "AGENDAMENTOS",
                  fontSize: 30,
                  paddingBottom: 6,
                  paddingLeft: 0,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 15),
                  alignment: Alignment.topCenter,
                  color: AppColors.branco,
                  child: Column(
                    children: [
                      _calendarTimeLine(),
                      loading
                          ? const Expanded(
                              child: LoadingAnimation(),
                            )
                          : _agendamentoDoDia(),
                    ],
                  ),
                ),
              )
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
            ? Column(
                children: [
                  _imagemErro(),
                  _textoErro(),
                ],
              )
            : GridView.count(
                crossAxisCount: 1,
                childAspectRatio: _controller.altura * 0.002,
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
        child: Column(
          children: [
            _sizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  width: _controller.largura * 0.74,
                  child: _itemNome(
                    _controller.agendamentos[index].cliente!.nome!,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 32,
                ),
              ],
            ),
            _itemDataHorario(
              Util.dataEscrito(
                    DateTime.parse(
                        _controller.agendamentos[index].dataAgendamento!),
                  ) +
                  ' ás ' +
                  _controller.agendamentos[index].horarioAgendamento!,
            ),
            _itemStatus(_controller.agendamentos[index].situacao!.name),
          ],
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

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Nome",
      descricao: nome,
      maxLines: 1,
    );
  }

  ItemLista _itemDataHorario(String data) {
    return ItemLista(
      titulo: "Data e horário",
      descricao: data,
    );
  }

  ItemLista _itemStatus(String status) {
    return ItemLista(
      titulo: "Status",
      descricao: status,
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  ImagensWidget _imagemErro() {
    return ImagensWidget(
      image: "calendario.png",
      widthImagem: 300,
    );
  }

  TextAutenticacoesWidget _textoErro() {
    return TextAutenticacoesWidget(
      alignment: Alignment.center,
      paddingTop: 0,
      fontSize: 30,
      text: "Nenhum horário agendado.",
    );
  }
}
