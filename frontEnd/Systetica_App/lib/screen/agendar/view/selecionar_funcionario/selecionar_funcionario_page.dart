// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/screen/agendar/view/selecionar_funcionario/selecionar_funcionario_widget.dart';

class SelecionarFuncionarioPage extends StatefulWidget {
  SelecionarFuncionarioPage({Key? key, required this.empresa}) : super(key: key);
  Empresa empresa;

  @override
  SelecionarFuncionarioWidget createState() => SelecionarFuncionarioWidget();
}