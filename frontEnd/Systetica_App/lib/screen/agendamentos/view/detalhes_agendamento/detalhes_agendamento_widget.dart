// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/alert_dialog_widget.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/screen/agendamentos/agendamento_controller.dart';
import 'package:systetica/screen/agendamentos/view/detalhes_agendamento/detalhes_agendamento_page.dart';
import 'package:systetica/screen/agendar/component/agendar_componente.dart';
import 'package:systetica/style/app_colors..dart';
import 'package:systetica/utils/util.dart';
import 'package:brasil_fields/brasil_fields.dart';

class DetalhesAgendamentoWidget extends State<DetalhesAgendamentoPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendamentoController _controller = AgendamentoController();

  double total = 0;

  @override
  void initState() {
    super.initState();
    widget.agendamentoServico.servicos!.forEach((element) {
      total += element.preco!;
    });
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
        widget.agendamentoServico.situacao!.name == "AGENDADO"
            ? AgendarComponente.botaoSelecinar(
                altura: _controller.altura,
                largura: _controller.largura,
                corBotao: Colors.black87.withOpacity(0.9),
                overlayCorBotao: AppColors.blue5,
                labelText: "DESMARCAR",
                onPressed: () {
                  confirmaCancelamento();
                })
            : const SizedBox(),
      ],
    );
  }

  Widget _checkboxSelect() {
    int itemCount = widget.agendamentoServico.servicos!.length;
    String titulo;
    itemCount > 1 ? titulo = "Serviços" : titulo = "Serviço";
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
                texto: titulo,
              ),
              ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return _listSelecao(
                    nome: widget.agendamentoServico.servicos![index].nome!,
                    subTitulo: widget
                            .agendamentoServico.servicos![index].tempoServico
                            .toString() +
                        ' min',
                    icon: CupertinoIcons.scissors_alt,
                    maxLines: widget.agendamentoServico.servicos!.length,
                  );
                },
              ),
              _titulo(texto: "Total"),
              _listSelecao(
                nome: UtilBrasilFields.obterReal(
                  total,
                ),
                terSubTituulo: false,
                icon: Icons.phone_android,
              ),
              _titulo(texto: "Barbeiro"),
              _listSelecao(
                nome: widget.agendamentoServico.funcionario!.nome!,
                terSubTituulo: false,
                icon: Icons.person,
              ),
              _titulo(texto: "Data e horário"),
              _listSelecao(
                nome: Util.dataEscrito(
                  DateTime.parse(
                    widget.agendamentoServico.dataAgendamento!,
                  ),
                ),
                subTitulo: widget.agendamentoServico.horarioAgendamento!,
                icon: Icons.calendar_month,
              ),
              _titulo(texto: "Status"),
              _listSelecao(
                nome: widget.agendamentoServico.situacao!.name,
                terSubTituulo: false,
                icon: Icons.phone_android,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmaCancelamento() {
    var alertDialog = AlertDialogWidget();
    alertDialog.alertDialog(
      showModalOk: false,
      context: context,
      titulo: "Atenção!",
      descricao: "Tem certeza que dejesa cancelar o serviço?",
      onPressedNao: () => Navigator.pop(context),
      onPressedOk: () async {
        Navigator.pop(context);
        await _controller
            .cancelarAgendamento(
              agendamentoServico: widget.agendamentoServico,
              context: context,
            )
            .then(
              (value) => setState(
                () {},
              ),
            );
        Navigator.pop(context);
      },
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
