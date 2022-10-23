// ignore_for_file: unused_field

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:systetica/model/PagamentoProduto.dart';
import 'package:systetica/model/Produto.dart';
import 'package:systetica/screen/pagamento_produto/view/selecionar_produto/selecionar_produto_page.dart';
import 'package:systetica/screen/produto/produto_controller.dart';

import '../../../../components/gesture_detector_component.dart';
import '../../../../components/icon_arrow_widget.dart';
import '../../../../components/loading/loading_animation.dart';
import '../../../../components/page_transition.dart';
import '../../../../style/app_colors.dart';
import '../../../agendar/component/agendar_componente.dart';
import '../../pagamento_produto_controller.dart';
import '../pagamento_produto/pagamento_produtos_page.dart';

class SelecionarProdutoWidget extends State<SelecionarProdutoPage> {
  final ScrollController _scrollController = ScrollController();
  final PagamentoProdutoController _controller = PagamentoProdutoController();
  final ProdutoController _produtoController = ProdutoController();
  var myPageTransition = MyPageTransition();

  late PagamentoProduto pagamentoProduto;
  List<Produto> produtos = [];
  bool loading = true;
  bool produtoSelecionado = false;

  @override
  void initState() {
    super.initState();
    pagamentoProduto = PagamentoProduto(
      produtos: [],
    );
    buscarProdutos();
  }

  Future<void> buscarProdutos() async {
    await _produtoController
        .buscarProdutosPorIdEmpresa(
          context: context,
          id: 1, // TODO
        )
        .then(
          (value) => setState(
            () {
              produtos = value!.object;
              loading = false;
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
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: IconArrowWidget(
          paddingTop: _controller.altura * 0.011,
          onPressed: () => Navigator.pop(context),
        ),
        body: loading ? const LoadingAnimation() : _body(),
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
              text: "SELECIONE O PRODUTO",
            ),
            _checkboxSelect(),
          ],
        ),
        AgendarComponente.botaoSelecinar(
          altura: _controller.altura,
          largura: _controller.largura,
          corBotao: _controller.corBotao,
          overlayCorBotao: _controller.overlayCorBotao,
          onPressed: () {
            produtoSelecionado == true
                ? Navigator.of(context)
                    .push(
                      myPageTransition.pageTransition(
                        child: PagamentoProdutosPage(
                          pagamentoProduto: pagamentoProduto,
                        ),
                        childCurrent: widget,
                        buttoToTop: true,
                      ),
                    )
                    .then(
                      (value) => setState(() {}),
                    )
                : null;
          },
        ),
      ],
    );
  }

  Widget _checkboxSelect() {
    return AgendarComponente.containerGeral(
      widget: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: produtos.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          String precoQuantidade =
              "${UtilBrasilFields.obterReal(produtos[index].precoVenda!)} - "
              "${produtos[index].quantEstoque!} em estoque";
          int totalList = produtos.length - 1;

          return GestureDetectorComponent(
            paddingBottom: index == totalList ? 0.3 : 0.04,
            largura: _controller.largura,
            altura: _controller.altura,
            textNome: produtos[index].nome!,
            precoMinuto: precoQuantidade,
            servicoSelecionado: produtos[index].produtoSelecionado,
            onChanged: (selecao) {
              produtos[index].produtoSelecionado = selecao;
              _adicionarRemoverServico(index);
              _ativarDesativarBotao();
              setState(() {});
            },
            onTap: () {
              _selecionarHorario(index);
              _adicionarRemoverServico(index);
              _ativarDesativarBotao();
              setState(() {});
            },
          );
        },
      ),
    );
  }

  void _selecionarHorario(int index) {
    produtos[index].produtoSelecionado == true
        ? produtos[index].produtoSelecionado = false
        : produtos[index].produtoSelecionado = true;
  }

  void _ativarDesativarBotao() {
    if (pagamentoProduto.produtos!.isEmpty) {
      produtoSelecionado = false;
      _controller.corBotao = Colors.grey.withOpacity(0.9);
      _controller.overlayCorBotao = Colors.transparent;
    } else {
      produtoSelecionado = true;
      _controller.corBotao = Colors.black87.withOpacity(0.9);
      _controller.overlayCorBotao = AppColors.blue5;
    }
  }

  void _adicionarRemoverServico(int index) {
    produtos[index].produtoSelecionado == true
        ? pagamentoProduto.produtos?.add(produtos[index])
        : pagamentoProduto.produtos?.removeWhere(
            (servico) => servico.id == produtos[index].id,
          );
  }
}
