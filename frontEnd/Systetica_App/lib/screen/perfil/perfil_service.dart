// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Token.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class PerfilService {
  static Future<Info> buscarUsuario(Token token) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.get("usuario/email/" + token.email!);

      info.object = Usuario.fromJson(response.data['response']);

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

  static Future<Info> atualizarUsuario(
    Token token,
    Usuario usuario,
  ) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response =
          await dio.put("usuario/atualizar", data: usuario.toJson());

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
