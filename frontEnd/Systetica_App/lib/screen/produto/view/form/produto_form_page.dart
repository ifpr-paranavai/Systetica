// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/Produto.dart';
import 'produto_form_widget.dart';

class ProdutoFormPage extends StatefulWidget {
  ProdutoFormPage({Key? key, this.produto}) : super(key: key);
  Produto? produto;

  @override
  ProdutoFormWidget createState() => ProdutoFormWidget();
}
