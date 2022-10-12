// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/AgendamentoServico.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class AgendamentoService {
  static Future<Info> buscarTodosAgendamentoPorDiaEmail({
    String? dataAgendamento,
    required Token token,
  }) async {
    String path =
        "agendar-servico/buscar-todos-por-dia?dia=$dataAgendamento&email=${token.email}";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = AgendamentoServico.fromJsonList(response.data['response']);

    return info;
  }
}
