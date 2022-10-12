// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/DadosAgendamento.dart';
import 'selecionar_funcionario_widget.dart';

class SelecionarFuncionarioPage extends StatefulWidget {
  SelecionarFuncionarioPage({Key? key, required this.dadosAgendamento})
      : super(key: key);
  DadosAgendamento dadosAgendamento;

  @override
  SelecionarFuncionarioWidget createState() => SelecionarFuncionarioWidget();
}
