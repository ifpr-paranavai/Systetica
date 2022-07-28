import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class ConnectionCheck {

  static Future<bool> check() async {
    int timeout = 5;
    try {
      http.Response response = await http.get(Uri.parse('http://neverssl.com/')).
      timeout(Duration(seconds: timeout));
      return response.statusCode == 200;
    } on TimeoutException catch (e) {
      // ignore: avoid_print
      print('Timeout Error: $e');
      return false;
    } on SocketException catch (e) {
      // ignore: avoid_print
      print('Socket Error: $e');
      return false;
    } on Error catch (e) {
      // ignore: avoid_print
      print('General Error: $e');
      return false;
    }
  }
}