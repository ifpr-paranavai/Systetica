// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';

import '../../../../components/alert_dialog_widget.dart';
import '../../../../components/horario_component.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../style/app_colors.dart';
import '../../../../utils/util.dart';
import '../../../agendar/component/agendar_componente.dart';
import '../../agendamento_controller.dart';
import 'detalhes_agendamento_page.dart';

class DetalhesAgendamentoWidget extends State<DetalhesAgendamentoPage> {
  final ScrollController _scrollController = ScrollController();
  final AgendamentoController _controller = AgendamentoController();

  double total = 0;

  @override
  void initState() {
    super.initState();
    widget.agendamento.servicos!.forEach((element) {
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
    bool podeCancelarServico = Util.podeCancelarServico(
      situacao: widget.agendamento.situacao!.nome,
      dataAgendamento: widget.agendamento.dataAgendamento!,
      horarioAgendamento: widget.agendamento.horarioAgendamento!,
    );
    return Stack(
      children: [
        Column(
          children: [
            AgendarComponente.info(
              altura: _controller.altura,
              largura: _controller.largura,
              text: "RESUMO DO AGENDAMENTO",
            ),
            _checkboxSelect(podeCancelarServico),
            HorarioComponent().sizedBox(height: _controller.altura * 0.08),
          ],
        ),
        podeCancelarServico
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

  Widget _checkboxSelect(bool podeCancelarServico) {
    int itemCount = widget.agendamento.servicos!.length;
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
              HorarioComponent().tituloDetalhes(texto: titulo),
              ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return HorarioComponent().listSelecao(
                    largura: _controller.largura,
                    nome: widget.agendamento.servicos![index].nome!,
                    subTitulo: widget.agendamento.servicos![index].tempoServico
                            .toString() +
                        ' min',
                    icon: CupertinoIcons.scissors_alt,
                    maxLines: widget.agendamento.servicos!.length,
                  );
                },
              ),
              HorarioComponent().tituloDetalhes(texto: "Total"),
              HorarioComponent().listSelecao(
                largura: _controller.largura,
                nome: UtilBrasilFields.obterReal(
                  total,
                ),
                terSubTituulo: false,
                icon: Icons.phone_android,
              ),
              HorarioComponent().tituloDetalhes(texto: "Barbeiro"),
              HorarioComponent().listSelecao(
                largura: _controller.largura,
                nome: widget.agendamento.funcionario!.nome!,
                terSubTituulo: false,
                icon: Icons.person,
              ),
              HorarioComponent().tituloDetalhes(texto: "Data e horário"),
              HorarioComponent().listSelecao(
                largura: _controller.largura,
                nome: Util.dataEscrito(
                  DateTime.parse(
                    widget.agendamento.dataAgendamento!,
                  ),
                ),
                subTitulo: widget.agendamento.horarioAgendamento!,
                icon: Icons.calendar_month,
              ),
              HorarioComponent().tituloDetalhes(texto: "Status"),
              HorarioComponent().listSelecao(
                largura: _controller.largura,
                nome: widget.agendamento.situacao!.nome,
                terSubTituulo: false,
                icon: Icons.phone_android,
              ),
              podeCancelarServico
                  ? const SizedBox()
                  : HorarioComponent().tituloDetalhes(
                      texto: "ATENÇÂO",
                      corFornte: AppColors.redPrincipal,
                    ),
              podeCancelarServico
                  ? const SizedBox()
                  : HorarioComponent().listSelecao(
                      maxLines: 3,
                      largura: _controller.largura,
                      nome:
                          "Só é permitido cancelar serviço com uma hora de atencedência.",
                      terSubTituulo: false,
                      icon: Icons.add_alert,
                      colorIcon: AppColors.redPrincipal,
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
              agendamento: widget.agendamento,
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
}
