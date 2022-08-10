// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/utils/dio/dio_config_api.dart';

class ServicoService{

  static Future<Info> buscarServico({
    int? size = 1000,
    String? servico,
  }) async {
    String path = "servico/buscar-todos?search=$servico&size=$size&sort=nome";

    Dio dio = DioConfigApi.builderConfig();

    var response = await dio.post(path);

    Info info = Info();

    info.success = true;
    info.object = Servico.fromJsonList(response.data['response']);

    return info;
  }
}