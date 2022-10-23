// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../components/horario_component.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/input/campo_pesquisa_pagamento_widget.dart';
import '../../../../components/input/campo_texto_widget.dart';
import '../../../../model/FormaPagamento.dart';
import '../../../../model/PagamentoServico.dart';
import '../../../../style/app_colors.dart';
import '../../../agendar/component/agendar_componente.dart';
import '../../pagamento_servico_controller.dart';
import 'pagamento_servico_page.dart';

class PagamentoServicoWidget extends State<PagamentoServicoPage> {
  final ScrollController _scrollController = ScrollController();
  final PagamentoServicoController _controller = PagamentoServicoController();
  double valorTotal = 0;

  @override
  void initState() {
    super.initState();
    _controller.pagamentoServico = PagamentoServico();
    widget.agendamento.servicos!.forEach((element) {
      valorTotal += element.preco!;
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
            HorarioComponent().sizedBox(height: _controller.altura * 0.08),
          ],
        ),
        widget.agendamento.situacao!.name == "AGENDADO"
            ? _botaoCadastrarPagamento()
            : const SizedBox(),
      ],
    );
  }

  Widget _botaoCadastrarPagamento() {
    return AgendarComponente.botaoSelecinar(
      altura: _controller.altura,
      largura: _controller.largura,
      corBotao: Colors.black87.withOpacity(0.9),
      overlayCorBotao: AppColors.blue5,
      labelText: "CADASTRAR PAGAMENTO",
      onPressed: () async {
        await _controller.cadastrarPagamentoServico(
          context: context,
          agendamento: widget.agendamento,
          valorTotal: valorTotal,
        );
      },
    );
  }

  Widget _checkboxSelect() {
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
                  valorTotal,
                ),
                terSubTituulo: false,
                icon: Icons.phone_android,
              ),
              inputDesconto(),
              inputTipoPagamento()
            ],
          ),
        ),
      ),
    );
  }

  CampoTextoWidget inputDesconto() {
    return CampoTextoWidget(
      labelText: "Desconto",
      paddingHorizontal: 20,
      keyboardType: TextInputType.number,
      paddingBottom: 0,
      maxLength: 6,
      paddingTop: 8,
      isIconDate: true,
      icon: const Icon(
        CupertinoIcons.money_dollar,
        color: Colors.black87,
      ),
      controller: _controller.descontoController,
    );
  }

  CampoPesquisaPagamentoWidget inputTipoPagamento({
    FormaPagamento? formaPagamento,
  }) {
    return CampoPesquisaPagamentoWidget(
      paddingHorizontal: 20,
      labelSeachTextPrincipal: "Forma pagamento",
      labelSeachTextPesquisa: "Digite nome do pagamento",
      compareFn: (
        formaPagamento,
        buscarFormaPagamento,
      ) =>
          formaPagamento == buscarFormaPagamento,
      asyncItems: (filtro) => _controller.buscarFormaPagamento(filtro),
      onChanged: (value) => _controller.formaPagamento = value,
      formaPagamento: formaPagamento,
    );
  }
}
