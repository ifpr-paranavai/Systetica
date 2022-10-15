// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/Agendamento.dart';
import 'pagamento_servico_widget.dart';

class PagamentoServicoPage extends StatefulWidget {
  PagamentoServicoPage({Key? key, required this.agendamento}) : super(key: key);
  Agendamento agendamento;

  @override
  PagamentoServicoWidget createState() => PagamentoServicoWidget();
}
