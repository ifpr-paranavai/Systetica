import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';

import '../../../components/erro/erro_widget.dart';
import '../../../components/icon_arrow_widget.dart';
import '../../../components/list_view/list_view_component.dart';
import '../../../components/loading/loading_animation.dart';
import '../../../components/pesquisa_widget.dart';
import '../../../model/Info.dart';
import '../../../model/Produto.dart';
import '../../../style/app_colors.dart';
import '../produto_controller.dart';
import 'form/produto_form_page.dart';
import 'produto_page.dart';

class ProdutoWidget extends State<ProdutoPage> {
  final ProdutoController _controller = ProdutoController();
  final ScrollController _scrollController = ScrollController();
  Info? info = Info(success: true);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _controller.produtos = [];
    buscaServicos();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _altura * 0.011,
          onPressed: () => Navigator.pop(context),
        ),
        body: loading
            ? const LoadingAnimation()
            : _body(
                largura: _largura,
                altura: _altura,
                produtos: _controller.produtos,
              ),
      ),
    );
  }

  Future<void> buscaServicos() async {
    await _controller.buscarProdutos(context: context, produto: "").then(
          (value) => setState(
            () {
              info = value;
              _controller.produtos = value!.object;
              loading = false;
            },
          ),
        );
  }

  Widget _body({
    required double altura, //width
    required double largura,
    required List<Produto> produtos,
  }) {
    return Stack(
      children: [
        Column(
          children: [
            _pesquisarProduto(
              altura: altura,
              largura: largura,
            ),
            produtos.isEmpty
                ? ErroWidget().erroRequisicao(
                    largura: largura,
                    listaVazia: true,
                    altura: altura,
                    nenhumItem: "Nenhuma produto cadastrado",
                  )
                : _listView(
                    altura: altura,
                    largura: largura,
                    produtos: produtos,
                  ),
          ],
        ),
        buttonIconAdd(
          altura: altura,
          largura: largura,
        ),
      ],
    );
  }

  Widget _pesquisarProduto({
    required double altura, //width
    required double largura, //height
  }) {
    return PesquisaWidget(
      altura: altura,
      largura: largura,
      hintText: 'Buscar produto...',
      onChanged: (value) async {
        _controller.produtos = [];
        _controller.buscarProdutos(context: context, produto: value).then(
              (value) => setState(() {
                _controller.produtos = value!.object;
              }),
            );
      },
    );
  }

  Widget _listView({
    required double altura,
    required double largura,
    required List<Produto> produtos,
  }) {
    return Expanded(
      child: Container(
        color: AppColors.branco,
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.only(
            left: largura * 0.04,
            right: largura * 0.04,
          ),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            return ListViewComponent(
              largura: largura,
              altura: altura,
              infoNome: produtos[index].nome!,
              infoPreco: UtilBrasilFields.obterReal(
                produtos[index].precoVenda!,
              ),
              numero: index + 1,
              maxLinesInfo: 2,
              onTap: () {
                Navigator.of(context)
                    .push(
                      _controller.myPageTransition.pageTransition(
                        child: ProdutoFormPage(produto: produtos[index]),
                        childCurrent: widget,
                        buttoToTop: true,
                      ),
                    )
                    .then(
                      (value) => setState(() {
                        buscaServicos();
                      }),
                    );
              },
            );
          },
        ),
      ),
    );
  }

  Widget buttonIconAdd({
    required double altura,
    required double largura,
  }) {
    return Container(
      padding: EdgeInsets.only(
        bottom: altura * 0.04,
        right: altura * 0.04,
      ),
      alignment: Alignment.bottomRight,
      child: IconButton(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.add_circle_outlined,
          color: AppColors.bluePrincipal.withOpacity(.9),
          size: 60,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(
                _controller.myPageTransition.pageTransition(
                  child: ProdutoFormPage(),
                  childCurrent: widget,
                  buttoToTop: true,
                ),
              )
              .then(
                (value) => setState(() {
                  buscaServicos();
                }),
              );
        },
      ),
    );
  }
}
