// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/DadosAgendamento.dart';
import 'selecionar_horario_widget.dart';

class SelecionarHorarioPage extends StatefulWidget {
  SelecionarHorarioPage({Key? key, required this.dadosAgendamento})
      : super(key: key);
  DadosAgendamento dadosAgendamento;

  @override
  SelecionarHorarioWidget createState() => SelecionarHorarioWidget();
}
