import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/single_child_scroll_component.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/servico/component/input_servico.dart';
import 'package:systetica/screen/servico/servico_controller.dart';
import 'package:systetica/screen/servico/view/detalhe/servico_detalhe_page.dart';

class ServicoDetalheWidget extends State<ServicoDetalhePage> {
  final InputServico _inputEmpresa = InputServico();
  final ServicoController _controller = ServicoController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.01,
          onPressed: () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            SingleChildScrollComponent(
              widgetComponent: Center(
                child: Column(
                  children: [
                    _sizedBox(height: _altura * 0.08),
                    _inputEmpresa.textoCadastrarServico(texto: "Detalhe Serviço"),
                    _cardInfoServico(
                      servico: widget.servico,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _cardInfoServico({required Servico servico}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _sizedBox(height: 5),
            _itemNome(servico.nome!),
            _itemDuracao(servico.tempoServico.toString()),
            _itemPreco(servico.preco.toString()),
            _itemDescricao(servico.descricao!),
          ],
        ),
      ),
    );
  }

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Nome",
      descricao: nome,
    );
  }

  ItemLista _itemDuracao(String duracao) {
    return ItemLista(
      titulo: "Duração do serviço",
      descricao: duracao + " minutos",
    );
  }

  ItemLista _itemPreco(String preco) {
    return ItemLista(
      titulo: "Preço",
      descricao: "R\$" + preco,
    );
  }

  ItemLista _itemDescricao(String descricao) {
    return ItemLista(
      titulo: "Descrição",
      descricao: descricao,
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
