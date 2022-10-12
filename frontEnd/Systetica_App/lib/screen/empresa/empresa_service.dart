// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';

import '../../model/BrasilCep.dart';
import '../../model/Cidade.dart';
import '../../model/Empresa.dart';
import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../utils/dio/dio_config_api.dart';

class EmpresaService {
  static Future<Info> cadastrarEmpresa(Token token, Empresa empresa) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.post("empresa/salvar", data: empresa.toJson());

      info = Info.fromJson(response.data);

      return info;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Erro de requisição: ${e.message}");
        }
        info.success = false;
        info.message = "Ocorreu algum erro ao tentar salvar empresa";
        return info;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }

  static Future<Info> atualizarEmpresa(Token token, Empresa empresa) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.put("empresa/atualizar", data: empresa.toJson());

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

  static Future<BrasilCep> buscaCep(String cep) async {
    BrasilCep brasilCep = BrasilCep();
    try {
      Dio dio = DioConfigApi.builderConfigJsonBrasilApi();

      var response = await dio.get("cep/v2/" + cep);

      brasilCep = BrasilCep.fromJson(response.data);
      return brasilCep;
    } on DioError catch (e) {
      return brasilCep;
    } on Exception catch (ex) {
      return brasilCep;
    }
  }

  static Future<Info> buscarCidade({
    int? size = 9,
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
}
