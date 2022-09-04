// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class AgendarService {
  static Future<Info> buscarEmpresas({
    int? size = 1000,
    String? usuarioBusca,
    required Token token,
  }) async {
    String path =
        "empresa/buscar-nome?search=$usuarioBusca&size=$size&sort=nome";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Empresa.fromJsonList(response.data['response']);

    return info;
  }
}