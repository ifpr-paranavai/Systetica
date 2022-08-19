// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Produto.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class ProdutoService {
  static Future<Info> buscarProdutos({
    int? size = 1000,
    String? servico,
  }) async {
    String path = "produto/buscar-todos?search=$servico&size=$size&sort=nome";

    Dio dio = DioConfigApi.builderConfig();

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Produto.fromJsonList(response.data['response']);

    return info;
  }
}
