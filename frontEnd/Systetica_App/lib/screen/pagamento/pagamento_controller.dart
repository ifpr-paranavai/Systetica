import 'package:systetica/screen/pagamento/pagamento_service.dart';

import '../../database/repository/token_repository.dart';
import '../../model/FormaPagamento.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';

class PagamentoController {
  Future<List<FormaPagamento>> buscarFormaPagamento(String? nome) async {
    try {
      Token _token = await TokenRepository.findToken();
      Info info = await PagamentoService.buscarFormaPagamento(
        token: _token,
        nome: nome,
      );
      return info.object;
    } catch (e) {
      return [];
    }
  }
}
