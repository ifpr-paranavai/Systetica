import 'package:dio/dio.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class AutenticacaoService {
  static Future<List<CidadeDTO>> buscarTodasCidades() async {
    Dio dio = DioConfigApi.builderConfig();

    var request = await dio.post("cidade/buscar-todos");

    return CidadeDTO.fromJsonList(request.data['response']);
  }
}
