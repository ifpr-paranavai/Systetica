// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/agendamento.dart';
import 'package:systetica/screen/agendar/view/resumo_agendamento/resumo_agenda_widget.dart';

class ResumoAgendaPage extends StatefulWidget {
  ResumoAgendaPage({Key? key, required this.agendamento})
      : super(key: key);
  Agendamento agendamento;

  @override
  ResumoAgendaWidget createState() => ResumoAgendaWidget();
}
