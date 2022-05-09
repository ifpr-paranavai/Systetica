import 'package:dio/dio.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class CadastroService {

  static Future<UsuarioDTO?> cadastro(UsuarioDTO usuarioDTO) async {
    Dio dio = DioConfigApi.builderConfigJson();

    UsuarioDTO? usuarioDTO2;
    try {
      var request = await dio.post("usuario/salvar", data: usuarioDTO.toJson());

      if(request.statusCode == 200){
        print("Sucesso");
      } else {
        print("Errou");
      }

      return usuarioDTO2;
    } catch (e) {
      return usuarioDTO2;
    }
  }

}