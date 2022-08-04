// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class CadastroService {
  static Future<Info> cadastroUsuario(Usuario usuario) async {
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      var response = await dio.post("usuario/salvar", data: usuario.toJson());
     
      return Info.fromJson(response.data);
    } on DioError catch (e) {
      try{
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


  static Future<Info> ativarUsuario(Usuario usuario) async {
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      var response = await dio.put("usuario/ativar", data: usuario.toJson());

      return Info.fromJson(response.data);
    } on DioError catch (e) {
      try{
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
