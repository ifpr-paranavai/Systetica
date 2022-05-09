import 'package:dio/dio.dart';
import 'package:systetica/model/LoginDTO.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class LoginService {
  static Future<void> login(LoginDTO loginDTO) async {
    Dio dio = DioConfigApi.builderConfig();

    UsuarioDTO? usuarioDTO;

    FormData formData = FormData.fromMap({
      'email': loginDTO.email,
      'password': loginDTO.password,
    });

    try {
      var request = await dio.post("login", data: formData);
      if(request.statusCode == 200){
        print("Sucesso");
      } else {
        print("Errou");
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
