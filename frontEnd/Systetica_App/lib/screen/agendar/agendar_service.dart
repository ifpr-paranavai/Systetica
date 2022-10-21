// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';

import '../../model/Empresa.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../model/DadosAgendamento.dart';
import '../../utils/dio/dio_config_api.dart';

class AgendarService {
  static Future<Info> buscarEmpresas({
    int? size = 1000,
    required Token token,
  }) async {
    String path = "empresa/buscar-todos?search=&size=$size";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Empresa.fromJson(response.data['response']);

    return info;
  }

  static Future<Info> buscarTodosAgendamentoPorDia({
    String? dataAgendamento,
    required Token token,
  }) async {
    String path = "agendamento/buscar-todos-por-dia?dia=$dataAgendamento";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = response.data['response'];

    return info;
  }

  static Future<Info> agendarHorario({
    required Token token,
    required DadosAgendamento dadosAgendamento,
  }) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.post(
        "agendamento/salvar",
        data: dadosAgendamento.toJson(),
      );

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
