// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/agendamento.dart';
import 'selecionar_funcionario_widget.dart';

class SelecionarFuncionarioPage extends StatefulWidget {
  SelecionarFuncionarioPage({Key? key, required this.agendamento})
      : super(key: key);
  Agendamento agendamento;

  @override
  SelecionarFuncionarioWidget createState() => SelecionarFuncionarioWidget();
}
