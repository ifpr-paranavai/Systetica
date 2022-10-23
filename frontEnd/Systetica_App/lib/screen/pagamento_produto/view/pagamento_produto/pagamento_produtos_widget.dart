// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:systetica/model/PagamentoProduto.dart';

import '../../../../components/horario_component.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/input/campo_pesquisa_pagamento_widget.dart';
import '../../../../components/input/campo_texto_widget.dart';
import '../../../../model/FormaPagamento.dart';
import '../../../../model/validator/MultiValidatorProduto.dart';
import '../../../../style/app_colors.dart';
import '../../../agendar/component/agendar_componente.dart';
import '../../../pagamento/pagamento_controller.dart';
import '../../pagamento_produto_controller.dart';
import 'pagamento_produtos_page.dart';

class PagamentoProdutosWidget extends State<PagamentoProdutosPage> {
  final ScrollController _scrollController = ScrollController();
  final PagamentoProdutoController _controller = PagamentoProdutoController();
  final PagamentoController _pagamentoController = PagamentoController();
  final MultiValidatorProduto _validatorProduto = MultiValidatorProduto();
  double valorTotal = 0;

  @override
  void initState() {
    super.initState();
    _controller.pagamentoProduto = PagamentoProduto();
    widget.pagamentoProduto.produtos!.forEach((element) {
      valorTotal += element.precoVenda!;
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
              text: "CADASTRAR PAGAMENTO PRODUTO",
            ),
            _checkboxSelect(),
            HorarioComponent().sizedBox(
              height: _controller.altura * 0.08,
            ),
          ],
        ),
        _botaoCadastrarPagamento()
      ],
    );
  }

  Widget _checkboxSelect() {
    int itemCount = widget.pagamentoProduto.produtos!.length;
    String titulo;
    itemCount > 1
        ? titulo = "Produtos selecionados"
        : titulo = "Produto selecionado";
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
                    nome: widget.pagamentoProduto.produtos![index].nome!,
                    subTitulo: widget
                            .pagamentoProduto.produtos![index].quantEstoque
                            .toString() +
                        ' em estoque',
                    icon: CupertinoIcons.scissors_alt,
                    maxLines: widget.pagamentoProduto.produtos!.length,
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
              ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return inputQuantidadeEstoqueProduto(
                    widget.pagamentoProduto.produtos![index]
                        .quantidadeVendidaController,
                    widget.pagamentoProduto.produtos![index].nome!,
                  );
                },
              ),
              inputTipoPagamento(),
              inputDesconto(),
            ],
          ),
        ),
      ),
    );
  }

  CampoTextoWidget inputQuantidadeEstoqueProduto(
    TextEditingController? controller,
    String nomeProduto,
  ) {
    return CampoTextoWidget(
      labelText: "Quant. de " + nomeProduto + " vendido",
      paddingHorizontal: 20,
      paddingTop: 15,
      paddingBottom: 0,
      keyboardType: TextInputType.number,
      maxLength: 4,
      isIconDate: true,
      icon: const Icon(
        Icons.numbers,
        color: Colors.black87,
      ),
      controller: controller,
      validator: _validatorProduto.quantEstoqueValidator,
    );
  }

  CampoTextoWidget inputDesconto() {
    return CampoTextoWidget(
      labelText: "Desconto",
      paddingHorizontal: 20,
      paddingTop: 25,
      paddingBottom: 25,
      keyboardType: TextInputType.number,
      maxLength: 6,
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
      asyncItems: (filtro) => _pagamentoController.buscarFormaPagamento(filtro),
      onChanged: (value) => _controller.formaPagamento = value,
      formaPagamento: formaPagamento,
    );
  }

  Widget _botaoCadastrarPagamento() {
    return AgendarComponente.botaoSelecinar(
      altura: _controller.altura,
      largura: _controller.largura,
      corBotao: Colors.black87.withOpacity(0.9),
      overlayCorBotao: AppColors.blue5,
      labelText: "CADASTRAR PAGAMENTO",
      onPressed: () async {},
    );
  }
}
