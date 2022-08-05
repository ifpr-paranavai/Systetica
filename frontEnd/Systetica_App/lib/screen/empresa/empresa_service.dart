// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Cidade.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class EmpresaService {
  static Future<Info> buscaEmpresa(Token token) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.get("empresa/email/" + token.email!);

      info.object = Empresa.fromJson(response.data['response']);

      return info;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Erro de requisição: ${e.message}");
        }
        info.success = false;
        info.message = "Erro: ${e.message}";
        return info;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }

  static Future<Info> buscarCidade({
    int? pageNumber,
    int? size = 5,
    String? nomeCidade,
  }) async {
    String path = "cidade/buscar-todos?search=$nomeCidade&size=$size";

    Dio dio = DioConfigApi.builderConfig();

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Cidade.fromJsonList(response.data['response']);

    return info;
  }

  static Future<Info> atualizarEmpresa(
      Token token,
      Empresa empresa,
      ) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response =
      await dio.put("empresa/atualizar", data: empresa.toJson());

      info = Info.fromJson(response.data);

      return info;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Erro de requisição: ${e.message}");
        }
        info.success = false;
        info.message = "Erro: ${e.message}";
        return info;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
