// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/Agendamento.dart';
import 'detalhes_agendamento_widget.dart';

class DetalhesAgendamentoPage extends StatefulWidget {
  DetalhesAgendamentoPage({Key? key, required this.agendamento})
      : super(key: key);
  Agendamento agendamento;

  @override
  DetalhesAgendamentoWidget createState() => DetalhesAgendamentoWidget();
}
