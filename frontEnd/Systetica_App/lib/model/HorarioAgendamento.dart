// ignore_for_file: file_names

class HorarioAgendamento {
  HorarioAgendamento({
    this.dateTime,
    this.horario,
    this.selecionado = false,
  });

  DateTime? dateTime;
  String? horario;
  bool selecionado;
}
