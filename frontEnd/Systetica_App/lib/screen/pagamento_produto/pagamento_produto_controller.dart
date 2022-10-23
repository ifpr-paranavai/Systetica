import 'package:flutter/material.dart';

import '../../components/page_transition.dart';
import '../../model/FormaPagamento.dart';
import '../../model/PagamentoProduto.dart';

class PagamentoProdutoController {
  final descontoController = TextEditingController();

  final myPageTransition = MyPageTransition();
  final formKey = GlobalKey<FormState>();
  late PagamentoProduto pagamentoProduto = PagamentoProduto();

  Color corBotao = Colors.grey.withOpacity(0.9);
  Color overlayCorBotao = Colors.transparent;
  double largura = 0;
  double altura = 0;
  FormaPagamento? formaPagamento;


}