// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/HorarioAgendamento.dart';
import 'package:intl/intl.dart';

class Util {
  static bool isEmptOrNull(String? obj) {
    if (obj == null || obj.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isIntegerNull(int? obj) {
    if (obj == null) {
      return true;
    } else {
      return false;
    }
  }

  static String emailDecode(String token) {
    Map<String, dynamic> tokenDecodificado = JwtDecoder.decode(token);

    return tokenDecodificado['sub'];
  }

  static double toDouble(String dinheiro) {
    var din = double.parse(dinheiro.replaceAll(',', '.'));
    return din;
  }

  static String toSplitNome(String nome) {
    return nome.split(" ")[0];
  }

  static Map<String, String> diasHorarioFuncionamento(
    String horaAbertura,
    String horaFechamento,
  ) {
    return {
      'Segunda-Feira': horaAbertura + ' - ' + horaFechamento,
      'Terça-Feira': horaAbertura + ' - ' + horaFechamento,
      'Quarta-Feira': horaAbertura + ' - ' + horaFechamento,
      'Quinta-Feira': horaAbertura + ' - ' + horaFechamento,
      'Sexta-Feira': horaAbertura + ' - ' + horaFechamento,
      'Sábado': horaAbertura + ' - ' + horaFechamento,
      'Domingo': 'Fechado',
    };
  }

  static int toIntHorario({
    required String horario,
    int contador = 0,
  }) {
    return int.parse(horario.split(':')[0]) + contador;
  }

  static String toHorario(int horario) {
    String hora = horario.toString() + ":00";
    horario.toString().length == 1
        ? hora = "0" + horario.toString() + ":00"
        : null;
    return hora;
  }

  static List<HorarioAgendamento> criarTodoHorarioAgendamento({
    required Empresa empresa,
    required List<dynamic> horariosMarcados,
    required DateTime dataSelecionada,
  }) {
    DateTime dataAtual = DateTime.now();
    List<HorarioAgendamento> horariosAgendamento = [];
    int contador = 0;

    // Verificação se é o mesmo dia para
    // mostrar apenas horários disponíveis acima do horário atual
    if (dataAtual.day == dataSelecionada.day &&
        dataAtual.month == dataSelecionada.month &&
        dataAtual.year == dataSelecionada.year) {
      dataSelecionada = dataAtual;
    }

    // Verificar o total de horários a serem gerados
    int totalHorario = toIntHorario(
          horario: empresa.horarioFechamento!,
        ) -
        toIntHorario(
          horario: empresa.horarioAbertura!,
          contador: 1,
        );

    for (int x = 0; x <= totalHorario; x++) {
      HorarioAgendamento hora = HorarioAgendamento();

      int horario = toIntHorario(
        horario: empresa.horarioAbertura!,
        contador: contador,
      );
      hora.horario = toHorario(horario);

      if (horario <= dataSelecionada.hour) {
        continue;
      } else if (dataSelecionada.isBefore(dataAtual)) {
        continue;
      } else {
        bool existeHorarioAgendado = false;
        for (var horario in horariosMarcados) {
          if (horario == hora.horario) {
            existeHorarioAgendado = true;
            break;
          }
        }
        existeHorarioAgendado == false ? horariosAgendamento.add(hora) : null;
      }

      hora.dateTime = dataSelecionada;
      contador += 1;
    }

    return horariosAgendamento;
  }

  static String dataEscrito(DateTime dateTime) {
    return DateFormat("d 'de' MMMM 'de' y", "pt_BR").format(
      dateTime,
    );
  }
}
