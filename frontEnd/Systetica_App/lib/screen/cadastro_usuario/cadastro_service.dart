import 'package:dio/dio.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Page_impl.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class CadastroService {
  static Future<Info> cadastroUsuario(UsuarioDTO usuarioDTO) async {
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      var response = await dio.post("usuario/salvar", data: usuarioDTO.toJson());
     
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

  // Todo - Remover deste service
  Future<PageImpl> buscarCidade({
    int? pageNumber,
    int? size = 10,
    String? nomeCidade,
  }) async {
    String path = "cidade/buscar-todos?search=$nomeCidade&size=$size";

    Dio dio = DioConfigApi.builderConfig();

    var response = await dio.post(path);

    PageImpl page = PageImpl();

    page.content = CidadeDTO.fromJsonList(response.data['response']);

    return page;
  }

  static Future<Info> ativarUsuario(UsuarioDTO usuarioDTO) async {
    try {
      Dio dio = DioConfigApi.builderConfigJson();

      var response = await dio.put("usuario/ativar-usuario", data: usuarioDTO.toJson());

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
