// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/agendamento.dart';
import 'selecionar_horario_widget.dart';

class SelecionarHorarioPage extends StatefulWidget {
  SelecionarHorarioPage({Key? key, required this.agendamento})
      : super(key: key);
  Agendamento agendamento;

  @override
  SelecionarHorarioWidget createState() => SelecionarHorarioWidget();
}
