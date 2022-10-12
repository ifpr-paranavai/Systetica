// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/agendamento.dart';
import 'resumo_agenda_widget.dart';

class ResumoAgendaPage extends StatefulWidget {
  ResumoAgendaPage({Key? key, required this.agendamento}) : super(key: key);
  Agendamento agendamento;

  @override
  ResumoAgendaWidget createState() => ResumoAgendaWidget();
}
