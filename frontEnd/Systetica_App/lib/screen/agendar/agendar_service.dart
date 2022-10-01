// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/model/agendamento.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class AgendarService {
  static Future<Info> buscarEmpresas({
    int? size = 1000,
    String? nomeEmpresa,
    required Token token,
  }) async {
    String path = "empresa/buscar-todos?search=$nomeEmpresa&size=$size";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Empresa.fromJsonList(response.data['response']);

    return info;
  }

  static Future<Info> buscarTodosAgendamentoPorDia({
    String? dataAgendamento,
    required Token token,
  }) async {
    String path = "agendar-servico/buscar-todos-por-dia/$dataAgendamento";

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
    required Agendamento agendamento,
  }) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.post("agendar-servico/salvar", data: agendamento.toJson());

      // info = Info.fromJson(response.data);

      return info;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Erro de requisição: ${e.message}");
        }
        info.success = false;
        info.message = "Ocorreu algum erro ao tentar salvar um agendamento";
        return info;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
