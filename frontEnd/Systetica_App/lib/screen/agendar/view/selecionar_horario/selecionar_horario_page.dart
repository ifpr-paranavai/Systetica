// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/agendamento.dart';
import 'package:systetica/screen/agendar/view/selecionar_horario/selecionar_horario_widget.dart';

class SelecionarHorarioPage extends StatefulWidget {
  SelecionarHorarioPage({Key? key, required this.agendamento}) : super(key: key);
  Agendamento agendamento;

  @override
  SelecionarHorarioWidget createState() => SelecionarHorarioWidget();
}