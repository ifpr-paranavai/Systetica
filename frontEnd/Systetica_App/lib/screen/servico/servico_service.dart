// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class ServicoService{
  static Future<Info> cadastrarServico(Token token, Servico servico) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.post("servico/salvar", data: servico.toJson());

      info = Info.fromJson(response.data);

      return info;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Erro de requisição: ${e.message}");
        }
        info.success = false;
        info.message = "Ocorreu algum erro ao tentar salvar servico";
        return info;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }

  static Future<Info> buscarServico({
    int? size = 1000,
    String? servico,
  }) async {
    String path = "servico/buscar-todos?search=$servico&size=$size&sort=nome";

    Dio dio = DioConfigApi.builderConfig();

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Servico.fromJsonList(response.data['response']);

    return info;
  }
}