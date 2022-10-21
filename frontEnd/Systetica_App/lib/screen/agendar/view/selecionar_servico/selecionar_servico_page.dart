// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/Empresa.dart';
import 'selecionar_servico_widget.dart';

class SelecionarServicoPage extends StatefulWidget {
  SelecionarServicoPage({
    Key? key,
    required this.empresa,
    required this.agendamentoCliente,
  }) : super(key: key);
  Empresa empresa;
  bool agendamentoCliente;

  @override
  SelecionarServicoWidget createState() => SelecionarServicoWidget();
}
