import 'package:dio/dio.dart';

class DioConfigApi {
  static const urlLocal = "http://192.168.1.100:8090/";
  static Dio builderConfig() {
    var options = BaseOptions(
      baseUrl: urlLocal,
      connectTimeout: 120000,
      receiveTimeout: 120000,
    );

    Dio dio = Dio(options);
    return dio;
  }

  static Dio builderConfigFormData() {
    var options = BaseOptions(
      baseUrl: urlLocal,
      connectTimeout: 120000,
      receiveTimeout: 120000,
      headers: {"Content-Type": "multipart/form-data"},
    );

    Dio dio = Dio(options);
    return dio;
  }

  static Dio builderConfigJson() {
    var options = BaseOptions(
      baseUrl: urlLocal,
      connectTimeout: 120000,
      receiveTimeout: 120000,
      headers: {"Content-Type": "application/json"},
    );

    Dio dio = Dio(options);
    return dio;
  }

}