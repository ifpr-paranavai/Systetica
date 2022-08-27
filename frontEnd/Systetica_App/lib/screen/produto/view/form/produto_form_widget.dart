import 'package:flutter/material.dart';
import 'package:systetica/components/icon_arrow_widget.dart';
import 'package:systetica/model/Produto.dart';
import 'package:systetica/model/validator/MultiValidatorProduto.dart';
import 'package:systetica/screen/produto/component/input_produto.dart';
import 'package:systetica/screen/produto/produto_controller.dart';
import 'package:systetica/screen/produto/view/form/produto_form_page.dart';

class ProdutoFormWidget extends State<ProdutoFormPage> {
  final ProdutoController _controller = ProdutoController();
  final InputProduto _inputProduto = InputProduto();
  final MultiValidatorProduto _validatorProduto = MultiValidatorProduto();
  late ScrollController _scrollController;
  bool edicao = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Produto? produto = widget.produto;
    if (produto == null) {
      _controller.produto = Produto();
    } else {
      edicao = true;
      _controller.produto = produto;
      _controller.nomeController.text = _controller.produto.nome!;
      _controller.marcaController.text = _controller.produto.marca!;
      _controller.precoCompraController.text = _controller.produto.precoCompra.toString();
      _controller.precoVendaController.text = _controller.produto.precoVenda.toString();
      _controller.quantEstoqueVendaController.text = _controller.produto.quantEstoque.toString();
      _controller.status = _controller.produto.status;
    }
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
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _controller.formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _sizedBox(height: _altura * 0.15),
                  _inputProduto.textoCadastrarProduto(
                      texto: "Cadastrar Produto"),
                  _inputProduto.inputNomeProduto(
                      paddingHorizontal: _largura,
                      controller: _controller,
                      validatorProduto: _validatorProduto,
                  ),
                  _inputProduto.inputMarcaProduto(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorProduto: _validatorProduto,
                  ),
                  _inputProduto.inputPrecoCompra(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorProduto: _validatorProduto,
                  ),
                  _inputProduto.inputPrecoVenda(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorProduto: _validatorProduto,
                  ),
                  _inputProduto.inputQuantidadeEstoqueProduto(
                    paddingHorizontal: _largura,
                    controller: _controller,
                    validatorProduto: _validatorProduto,
                  ),

                  edicao
                      ? _inputProduto.customSwitch(
                          paddingHorizontal: _largura,
                          controller: _controller,
                          onChanged: (bool value) {
                            setState(() {
                              _controller.status = value;
                            });
                          },
                        )
                      : Container(),
                  _inputProduto.botaoCadastrar(
                    label: edicao ? "SALVAR" : "CADASTRAR",
                    onPressed: () => edicao
                        ? _controller.atualizarProduto(context).then(
                              (value) => Navigator.pop(context),
                            )
                        : _controller.cadastrarProduto(context).then(
                              (value) => Navigator.pop(context),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
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