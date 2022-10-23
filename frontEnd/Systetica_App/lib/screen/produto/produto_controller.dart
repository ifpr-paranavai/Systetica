import 'package:flutter/material.dart';
import 'package:systetica/screen/produto/produto_service.dart';

import '../../components/alert_dialog_widget.dart';
import '../../components/loading/show_loading_widget.dart';
import '../../components/page_transition.dart';
import '../../components/texto_erro_widget.dart';
import '../../database/repository/token_repository.dart';
import '../../model/Info.dart';
import '../../model/Produto.dart';
import '../../model/Token.dart';
import '../../request/dio_config.dart';
import '../../utils/util.dart';

class ProdutoController {
  final nomeController = TextEditingController();
  final marcaController = TextEditingController();
  final precoCompraController = TextEditingController();
  final precoVendaController = TextEditingController();
  final quantEstoqueVendaController = TextEditingController();
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Produto> produtos;
  late Produto produto;
  bool? status;

  Future<void> cadastrarProduto(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          try {
            var contextLoading = context;
            var loading = ShowLoadingWidget.showLoadingLabel(
              contextLoading,
              "Aguarde...",
            );

            Token _token = await TokenRepository.findToken();
            produto.nome = nomeController.text;
            produto.marca = marcaController.text;
            produto.precoCompra = Util.toDouble(precoCompraController.text);
            produto.precoVenda = Util.toDouble(precoVendaController.text);
            produto.quantEstoque = int.parse(quantEstoqueVendaController.text);
            produto.emailAdministrativo = _token.email;
            Info _info = await ProdutoService.cadastrarProduto(_token, produto);

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            var alertDialogOk = AlertDialogWidget();
            if (_info.success!) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content: TextoErroWidget(
                    mensagem: _info.message!,
                  ),
                ),
              );
            } else {
              alertDialogOk.alertDialog(
                showModalOk: true,
                context: context,
                titulo: "Erro",
                descricao: _info.message!,
                buttonText: "OK",
                onPressedOk: () => Navigator.pop(context),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.blueGrey,
                content: TextoErroWidget(
                  mensagem: "Ocorreu algum erro de comunicação com o servidor",
                ),
              ),
            );
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um serviço",
          ),
        ),
      );
    }
  }

  Future<void> atualizarProduto(BuildContext context) async {
    var connected = await ConnectionCheck.check();
    if (connected) {
      if (formKey.currentState != null) {
        if (formKey.currentState?.validate() ?? true) {
          try {
            var contextLoading = context;
            var loading = ShowLoadingWidget.showLoadingLabel(
              contextLoading,
              "Aguarde...",
            );

            Token _token = await TokenRepository.findToken();

            produto.nome = nomeController.text;
            produto.marca = marcaController.text;
            produto.precoCompra = double.parse(precoCompraController.text);
            produto.precoVenda = double.parse(precoVendaController.text);
            produto.quantEstoque = int.parse(quantEstoqueVendaController.text);
            produto.emailAdministrativo = _token.email;
            produto.status = status;

            Info _info = await ProdutoService.atualizarProduto(_token, produto);

            // Finaliza o loading na tela
            Navigator.pop(contextLoading, loading);

            var alertDialogOk = AlertDialogWidget();
            if (_info.success!) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content: TextoErroWidget(
                    mensagem: _info.message!,
                  ),
                ),
              );
            } else {
              alertDialogOk.alertDialog(
                showModalOk: true,
                context: context,
                titulo: "Erro",
                descricao: _info.message!,
                buttonText: "OK",
                onPressedOk: () => Navigator.pop(context),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.blueGrey,
                content: TextoErroWidget(
                  mensagem: "Ocorreu algum erro de comunicação com o servidor",
                ),
              ),
            );
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          padding: EdgeInsets.all(12),
          content: TextoErroWidget(
            mensagem: "Por Favor, conecte-se a rede para cadastrar um serviço",
          ),
        ),
      );
    }
  }

  Future<Info?> buscarProdutos({
    required BuildContext context,
    required String produto,
  }) async {
    Info info = Info(success: true);
    try {
      Token _token = await TokenRepository.findToken();
      info = await ProdutoService.buscarProdutos(
        produto: produto,
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }

  Future<Info?> buscarProdutosPorIdEmpresa({
    required BuildContext context,
    required int id,
  }) async {
    Info info = Info(success: true);

    try {
      Token _token = await TokenRepository.findToken();
      info = await ProdutoService.buscarProdutosPorIdEmpresa(
        id: id,
        token: _token,
      );
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }
}
