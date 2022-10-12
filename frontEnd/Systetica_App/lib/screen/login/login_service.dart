// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';

import '../../model/Info.dart';
import '../../model/Login.dart';
import '../../model/Token.dart';
import '../../model/Usuario.dart';
import '../../utils/dio/dio_config_api.dart';

class LoginService {
  static Future<Token?> login(Login login) async {
    Dio dio = DioConfigApi.builderConfigFormData();

    FormData formData = FormData.fromMap({
      'email': login.email,
      'password': login.password,
    });

    try {
      var response = await dio.post("login", data: formData);

      Token token = Token.fromJson(response.data);
      return token;
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Conexão Perdida: $e.message");
        } else if (e.response?.statusCode == 403) {
          throw Exception("Usuário ou senha incorreto");
        }
      } catch (e) {
        throw Exception(e);
      }
    } on Exception catch (ex) {
      rethrow;
    }
    return null;
  }

  static Future<Info> gerarCodigoAlterarSenha(String email) async {
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      var response = await dio.put(
        "usuario/gerar-codigo",
        queryParameters: {
          'email': email,
        }
      );

      return Info.fromJson(response.data);
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Conexão Perdida: $e.message");
        }
        return Info.fromJson(e.response!.data!);
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }

  static Future<Info> alterarSenha(Usuario usuario) async {
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      var response =
          await dio.put("usuario/alterar-senha", data: usuario.toJson());

      return Info.fromJson(response.data);
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Conexão Perdida: $e.message");
        }
        return Info.fromJson(e.response!.data!);
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
