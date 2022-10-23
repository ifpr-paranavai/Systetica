// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../model/Empresa.dart';
import '../model/HorarioAgendamento.dart';
import '../model/Produto.dart';

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
      hora.horarioAgendamento = toHorario(horario);

      if (horario <= dataSelecionada.hour) {
      } else if (dataSelecionada.isBefore(dataAtual)) {
      } else {
        bool existeHorarioAgendado = false;
        for (var horario in horariosMarcados) {
          if (horario == hora.horarioAgendamento) {
            existeHorarioAgendado = true;
            break;
          }
        }
        existeHorarioAgendado == false ? horariosAgendamento.add(hora) : null;
      }

      hora.dataAgendamento = dataSelecionada;
      contador += 1;
    }

    return horariosAgendamento;
  }

  static String dataEscrito(DateTime dateTime) {
    return DateFormat("d 'de' MMMM 'de' y", "pt_BR").format(
      dateTime,
    );
  }

  static bool podeCancelarServico({
    required String situacao,
    required String dataAgendamento,
    required String horarioAgendamento,
  }) {
    // Realiza-se essas transformações na data para ambas ficarem com a hora, minuto
    DateTime dataHora = DateTime.now();
    DateTime dataAgora = DateTime.parse(
      DateFormat('yyyy-MM-dd').format(dataHora),
    );
    DateTime dataAendamento2 = DateTime.parse(dataAgendamento);

    if (situacao != "AGENDADO") {
      return false;
    } else if (dataAendamento2.isBefore(dataAgora)) {
      return false;
    } else if (!dataAendamento2.isAfter(dataAgora) &&
        toIntHorario(horario: horarioAgendamento) < dataHora.hour) {
      return false;
    } else {
      return true;
    }
  }

  static bool validarQuantidadeVendidaMaiorQueEstoque(List<Produto> produtos) {
    bool maior = false;

    produtos.forEach((produto) {
      produto.quantidadeVendida > produto.quantEstoque!
          ? maior = true
          : maior = false;
    });

    return maior;
  }

  static double calcularValorTotal(List<Produto> produtos, double desconto) {
    double valorTotal = 0;

    produtos.forEach((produto) {
      valorTotal += produto.precoVenda! * produto.quantidadeVendida;
    });

    return valorTotal - desconto;
  }
}
