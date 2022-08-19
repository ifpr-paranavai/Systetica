import 'package:flutter/material.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Produto.dart';
import 'package:systetica/screen/produto/produto_service.dart';

class ProdutoController {
  final nomeController = TextEditingController();
  final marcaServicoController = TextEditingController();
  final precoCompraController = TextEditingController();
  final precoVendaController = TextEditingController();
  final quantEstoqueVendaController = TextEditingController();
  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late List<Produto> produtos;
  late Produto produto;
  bool? status;

  Future<Info?> buscarProdutos({
    required BuildContext context,
    required String servico,
  }) async {
    Info info = Info(success: true);

    try {
      info = await ProdutoService.buscarProdutos(servico: servico);
    } catch (e) {
      info.success = false;
      return info;
    }
    return info;
  }
}
