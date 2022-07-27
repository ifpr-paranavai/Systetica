import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/model/TokenDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class PerfilService {
  static Future<dynamic> buscarUsuario(TokenDTO tokenDTO) async {
    Info info = Info(success: true);
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${tokenDTO.accessToken}";

      var response = await dio.get("usuario/email/" + tokenDTO.email!);

      info.object = UsuarioDTO.fromJson(response.data['response']);

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
