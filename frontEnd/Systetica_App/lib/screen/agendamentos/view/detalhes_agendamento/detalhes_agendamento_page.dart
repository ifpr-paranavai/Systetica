// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/AgendamentoServico.dart';
import 'package:systetica/screen/agendamentos/view/detalhes_agendamento/detalhes_agendamento_widget.dart';

class DetalhesAgendamentoPage extends StatefulWidget {
  DetalhesAgendamentoPage({Key? key, required this.agendamentoServico})
      : super(key: key);
  AgendamentoServico agendamentoServico;

  @override
  DetalhesAgendamentoWidget createState() => DetalhesAgendamentoWidget();
}
