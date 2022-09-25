import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/HorarioAgendamento.dart';

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

  static int toInt(String horario) {
    var hora = int.parse(horario.replaceAll(':00', ''));
    return hora;
  }

  static String toHorario(int horario) {
    var hora;
    if (horario.toString().length == 1) {
      hora = "0" + horario.toString() + ":00";
    } else {
      hora = horario.toString() + ":00";
    }
    return hora;
  }

  static List<HorarioAgendamento> criarTodoHorarioAgendamento({
    required Empresa empresa,
    required List<dynamic> horariosMarcados,
  }) {
    List<HorarioAgendamento> horariosAgendamento = [];

    int totalHorario =
        (toInt(empresa.horarioFechamento!) - toInt(empresa.horarioAbertura!)) -
            1;

    int contador = 0;

    for (int x = 0; x <= totalHorario; x++) {
      HorarioAgendamento hora = HorarioAgendamento();

      hora.horario = toHorario((toInt(empresa.horarioAbertura!) + contador));

      bool existeHorarioAgendado = false;
      for (var element in horariosMarcados) {
        if (element == hora.horario) {
          existeHorarioAgendado = true;
          break;
        }
      }

      existeHorarioAgendado == false ? horariosAgendamento.add(hora) : null;

      contador += 1;
    }

    return horariosAgendamento;
  }
}
