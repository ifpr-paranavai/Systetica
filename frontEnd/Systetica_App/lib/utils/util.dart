import 'package:jwt_decoder/jwt_decoder.dart';

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
}
