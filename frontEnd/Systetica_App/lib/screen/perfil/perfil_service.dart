import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/model/TokenDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class PerfilService {
  static Future<UsuarioDTO> buscarUsuario(TokenDTO tokenDTO) async {
    UsuarioDTO usuarioDTO = UsuarioDTO();
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      dio.options.headers["Authorization"] = "Bearer ${tokenDTO.accessToken}";

      var response = await dio.get("usuario/email/" + tokenDTO.email!);

      return UsuarioDTO.fromJson(response.data);
    } on DioError catch (e) {
      try {
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Conexão Perdida: $e.message");
        }
        return usuarioDTO;
      } catch (e) {
        throw Exception(e.runtimeType);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
