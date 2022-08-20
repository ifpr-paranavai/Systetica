// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/Produto.dart';
import 'package:systetica/screen/produto/view/form/produto_form_widget.dart';

class ProdutoFormPage extends StatefulWidget {
  ProdutoFormPage({Key? key, this.produto}) : super(key: key);
  Produto? produto;

  @override
  ProdutoFormWidget createState() => ProdutoFormWidget();
}