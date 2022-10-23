// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/PagamentoProduto.dart';

import 'pagamento_produtos_widget.dart';

class PagamentoProdutosPage extends StatefulWidget {
  PagamentoProdutosPage({
    Key? key,
    required this.pagamentoProduto,
  }) : super(key: key);
  PagamentoProduto pagamentoProduto;

  @override
  PagamentoProdutosWidget createState() => PagamentoProdutosWidget();
}
