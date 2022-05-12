import 'package:dio/dio.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/Page_impl.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class CadastroService {
  static Future<UsuarioDTO?> cadastro(UsuarioDTO usuarioDTO) async {
    try {
      Dio dio = DioConfigApi.builderConfigJson();
      var response =
          await dio.post("usuario/salvar", data: usuarioDTO.toJson());
      return UsuarioDTO.fromJson(response.data['response']);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception("Conexão Perdida: $e.message");
      }
      throw Exception(e.message);
    } on Exception catch (ex) {
      rethrow;
    }
  }

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
}
