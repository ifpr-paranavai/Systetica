// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';

import '../../model/Agendamento.dart';
import '../../model/FormaPagamento.dart';
import '../../model/Info.dart';
import '../../model/PagamentoServico.dart';
import '../../model/Token.dart';
import '../../utils/dio/dio_config_api.dart';

class PagamentoServicoService {
  static Future<Info> buscarTodosAgendamentoPorDiaStatusAgendados({
    String? dataAgendamento,
    required Token token,
  }) async {
    String path =
        "agendamento/buscar-todos-por-dia-agendados?dia=$dataAgendamento";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Agendamento.fromJsonList(response.data['response']);

    return info;
  }

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

  static Future<Info> cadastrarPagamentoServico({
    required Token token,
    required PagamentoServico pagamentoServico,
  }) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.post(
        "pagamento/servico",
        data: pagamentoServico.toJson(),
      );

      info = Info.fromJson(response.data);

      return info;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Erro de requisição: ${e.message}");
        }
        info.success = false;
        info.message = "Ocorreu algum erro ao tentar cadastrar pagamento";
        return info;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
