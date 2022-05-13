import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/model/TokenDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class LoginService {
  static Future<Object> login(LoginDTO loginDTO) async {
    Dio dio = DioConfigApi.builderConfigFormData();

    FormData formData = FormData.fromMap({
      'email': loginDTO.email,
      'password': loginDTO.password,
    });

    try {
      var response = await dio.post("login", data: formData);

      var a = TokenDTO.fromJson(response.data);
      return a;
    } on DioError catch (e) {
      try{
        if (e.type == DioErrorType.connectTimeout) {
          throw Exception("Conexão Perdida: $e.message");
        }
        else if (e.response?.statusCode == 403) {
          throw Exception("Usuário ou senha incorreto");
        }
        return Info.fromJson(e.response!.data!);
      } catch (e) {
        throw Exception(e);
      }
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
