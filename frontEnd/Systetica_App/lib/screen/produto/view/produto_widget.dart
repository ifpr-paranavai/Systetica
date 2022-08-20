import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/list_view_component.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Produto.dart';
import 'package:systetica/screen/produto/produto_controller.dart';
import 'package:systetica/screen/produto/view/form/produto_form_page.dart';
import 'package:systetica/screen/produto/view/produto_page.dart';
import 'package:systetica/style/app_colors..dart';
import 'package:brasil_fields/brasil_fields.dart';

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
        backgroundColor: Colors.white,
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
            _pesquisaServico(
              altura: altura,
              largura: largura,
            ),
            produtos.isEmpty
                ? _erroRequisicao(
                    largura: largura,
                    listaVazia: true,
                  )
                : _listView(
                    altura: altura,
                    largura: largura,
                    produtos: produtos,
                  ),
          ],
        ),
        buttonIcon(
          altura: altura,
          largura: largura,
        ),
      ],
    );
  }

  Widget _pesquisaServico({
    required double altura, //width
    required double largura, //height
  }) {
    return Container(
      height: 70,
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.only(
        top: largura * 0.040,
        bottom: largura * 0.030,
        right: largura * 0.037,
        left: largura * 0.22,
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: largura / 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            // width: 0.15,
            width: 1,
          ),
        ),
        child: TextFormField(
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
            hintText: 'Buscar produto...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) async {
            _controller.produtos = [];
            _controller.buscarProdutos(context: context, produto: value).then(
                  (value) => setState(() {
                    _controller.produtos = value!.object;
                  }),
                );
          },
        ),
      ),
    );
  }

  Widget _listView({
    required double altura,
    required double largura,
    required List<Produto> produtos,
  }) {
    return Expanded(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
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
          itemBuilder: (BuildContext context, int index) {
            return ListViewComponent(
              largura: largura,
              altura: altura,
              infoNome: produtos[index].nome!,
              infoPreco:
                  UtilBrasilFields.obterReal(produtos[index].precoVenda!),
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

  Widget buttonIcon({
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

  // Widgets de erro
  Widget _erroRequisicao({
    required bool listaVazia,
    required double largura,
  }) {
    return Expanded(
      child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _imagemErro(listaVazia: listaVazia),
                    _textoErro(largura: largura, listaVazia: listaVazia),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  ImagensWidget _imagemErro({
    required bool listaVazia,
  }) {
    return ImagensWidget(
      paddingLeft: 0,
      image: listaVazia ? "list-vazia.png" : "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro({
    required double largura,
    required bool listaVazia,
  }) {
    return TextAutenticacoesWidget(
      paddingLeft: largura * (listaVazia ? 0.18 : 0.15),
      paddingRight: largura * 0.10,
      fontSize: 33,
      text: listaVazia
          ? "Nenhum produto cadastradoa."
          : "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
