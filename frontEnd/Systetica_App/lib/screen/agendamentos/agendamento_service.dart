// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';

import '../../model/Agendamento.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../utils/dio/dio_config_api.dart';


class AgendamentoService {
  static Future<Info> buscarTodosAgendamentoPorDiaEmail({
    String? dataAgendamento,
    required Token token,
  }) async {
    String path =
        "agendamento/buscar-todos-por-dia?dia=$dataAgendamento&email=${token.email}";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Agendamento.fromJsonList(response.data['response']);

    return info;
  }

  static Future<Info> cancelarAgendamento({
    required Token token,
    required Agendamento agendamento,
  }) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.post("agendamento/cancelar",
          data: agendamento.toJson());

      info = Info.fromJson(response.data);

      return info;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Erro de requisição: ${e.message}");
        }
        info = Info.fromJson(e.response?.data);
        return info;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
