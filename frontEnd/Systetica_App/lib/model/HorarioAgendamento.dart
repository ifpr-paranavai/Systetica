// ignore_for_file: file_names

import 'package:intl/intl.dart';

class HorarioAgendamento {
  HorarioAgendamento({
    this.dataAgendamento,
    this.horarioAgendamento,
    this.selecionado = false,
  });

  DateTime? dataAgendamento;
  String? horarioAgendamento;
  bool selecionado;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data_agendamento'] = DateFormat('yyyy-MM-dd').format(dataAgendamento!);
    _data['horario_agendamento'] = horarioAgendamento;
    return _data;
  }
}
