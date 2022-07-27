import 'package:jwt_decoder/jwt_decoder.dart';

class Util {
  static bool isEmptOrNull(String? obj) {
    if (obj == null || obj.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isIntegerNull(int? obj) {
    if (obj == null) {
      return true;
    } else {
      return false;
    }
  }

  static String emailDecode(String token) {
    Map<String, dynamic> tokenDecodificado = JwtDecoder.decode(token);

    return tokenDecodificado['sub'];
  }
}
