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

  static int toIntHorario(String horario) {
    return int.parse(horario.split(':')[0]);
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
  }) {
    List<HorarioAgendamento> horariosAgendamento = [];
    int contador = 0;

    int totalHorario = (toIntHorario(empresa.horarioFechamento!) -
            toIntHorario(empresa.horarioAbertura!)) -
        1;

    for (int x = 0; x <= totalHorario; x++) {
      HorarioAgendamento hora = HorarioAgendamento();

      hora.horario =
          (toIntHorario(empresa.horarioAbertura!) + contador).toString();

      bool existeHorarioAgendado = false;
      for (var horario in horariosMarcados) {
        if (horario == hora.horario) {
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
