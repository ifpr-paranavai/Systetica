// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/DadosAgendamento.dart';
import 'resumo_agenda_widget.dart';

class ResumoAgendaPage extends StatefulWidget {
  ResumoAgendaPage({Key? key, required this.dadosAgendamento}) : super(key: key);
  DadosAgendamento dadosAgendamento;

  @override
  ResumoAgendaWidget createState() => ResumoAgendaWidget();
}
