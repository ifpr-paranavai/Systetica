import 'package:dio/dio.dart';

class DioConfigApi {
  static const urlLocal = "http://192.168.1.100:8090/";
  static const timeOut = 120000;

  static Dio builderConfig() {
    var options = BaseOptions(
      baseUrl: urlLocal,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
    );

    return Dio(options);
  }

  static Dio builderConfigFormData() {
    var options = BaseOptions(
      baseUrl: urlLocal,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: {"Content-Type": "multipart/form-data"},
    );

    return Dio(options);
  }

  static Dio builderConfigJson() {
    var options = BaseOptions(
      baseUrl: urlLocal,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: {"Content-Type": "application/json"},
    );

    return Dio(options);
  }

}