// ignore_for_file: unused_catch_clause
import 'package:dio/dio.dart';

import '../../model/FormaPagamento.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../utils/dio/dio_config_api.dart';

class PagamentoService {
  static Future<Info> buscarFormaPagamento({
    required Token token,
    int? size = 9,
    String? nome,
  }) async {
    String path = "forma-pagamento/buscar-todos?search=$nome&size=$size";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = FormaPagamento.fromJsonList(response.data['response']);

    return info;
  }
}
