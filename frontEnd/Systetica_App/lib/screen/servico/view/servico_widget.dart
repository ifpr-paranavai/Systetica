import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/list_view_component.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/servico/servico_controller.dart';
import 'package:systetica/screen/servico/view/servico_page.dart';

class ServicoWidget extends State<ServicoPage> {
  final ServicoController _controller = ServicoController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.014,
          onPressed: () => Navigator.pop(context),
        ),
        body: FutureBuilder<Info?>(
          future: _controller.buscarServico(context: context, servico: ""),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else if (snapShot.hasData) {
              if (snapShot.data!.success!) {
                List<Servico> servicos = snapShot.data!.object;
                return _listaServicos(
                  largura: _largura,
                  altura: _altura,
                  servicos: servicos,
                );
              } else {
                return const Text("Nenhum serviço cadastrado");
              }
            } else {
              return _erroRequisicao(_largura);
            }
          },
        ),
      ),
    );
  }

  Widget _listaServicos({
    required double altura, //width
    required double largura,
    required List<Servico> servicos,
  }) {
    return Column(
      children: [
        pesquisa(
          altura: altura,
          largura: largura,
        ),
        Expanded(
          child: Container(
            color: Colors.grey.withOpacity(0.4),
            child: _listView(
              altura: altura,
              largura: largura,
              servicos: servicos,
            ),
          ),
        ),
      ],
    );
  }

  Widget pesquisa({
    required double altura, //width
    required double largura, //height
  }) {
    return Container(
      height: altura * 0.1,
      color: Colors.grey.withOpacity(0.4),
      padding: EdgeInsets.only(
        top: largura * 0.030,
        bottom: largura * 0.035,
        right: largura * 0.035,
        left: largura * 0.22,
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: largura / 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: Colors.black,
            // width: 0.15,
            width: 1,
          ),
        ),
        child: TextField(
          maxLines: 1,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(.4),
              fontWeight: FontWeight.w600,
              fontSize: largura / 22,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(.6),
            ),
            hintText: 'Buscar serviço...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _listView({
    required double altura,
    required double largura,
    required List<Servico> servicos,
  }) {
    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.all(largura * 0.04),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: servicos.length,
      itemBuilder: (BuildContext context, int index) {
        return ListViewComponent(
          largura: largura,
          altura: altura,
          titulo1: "Nome: ",
          titulo2: "Preço: ",
          descricao1: servicos[index].nome!,
          descricao2: "R\$ " + servicos[index].preco.toString(),
          numero: index + 1,
          onTap: () {},
        );
      },
    );
  }

  // Widgets de erro
  Center _erroRequisicao(double _largura) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagemErro(),
            _textoErro(_largura),
          ],
        ),
      ),
    );
  }

  ImagensWidget _imagemErro() {
    return ImagensWidget(
      paddingLeft: 0,
      image: "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro(double _largura) {
    return TextAutenticacoesWidget(
      paddingLeft: _largura * 0.10,
      paddingRight: _largura * 0.10,
      fontSize: 33,
      text: "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
