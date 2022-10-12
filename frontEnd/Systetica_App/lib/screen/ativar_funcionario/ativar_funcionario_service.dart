// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';

import '../../model/Info.dart';
import '../../model/Token.dart';
import '../../model/Usuario.dart';
import '../../utils/dio/dio_config_api.dart';

class AtivarFuncionarioService {
  static Future<Info> buscaUsuarios({
    int? size = 1000,
    String? usuarioBusca,
    required Token token,
  }) async {
    String path =
        "usuario/buscar-nome-email?search=$usuarioBusca&size=$size&sort=nome";

    Dio dio = DioConfigApi.builderConfig();

    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Usuario.fromJsonList(response.data['response']);

    return info;
  }

  static Future<Info> buscarFuncionarios({
    required Token token,
  }) async {
    Dio dio = DioConfigApi.builderConfig();
    dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

    String path = "usuario/buscar-funcionarios/${token.email}";

    var response = await dio.get(path);

    Info info = Info();

    info.success = true;
    info.object = Usuario.fromJsonList(response.data['response']);

    return info;
  }

  static Future<Info> concederPermissao(Token token, Usuario usuario) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${token.accessToken}";

      var response = await dio.put("usuario/permissao-funcionario", data: usuario.toJson());

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
