import 'package:systetica/model/TokenDTO.dart';

class TokenORM {
  static const String TABLE = "token";
  static const String ID = "id";
  static const String ACCESS_TOKEN = "access_token";
  static const String REFRESH_TOKEN = "refresh_token";

  int? id;
  String? accessToken;
  String? refreshToken;

  TokenORM({
    this.id,
    this.accessToken,
    this.refreshToken,
  });

  Map<String, Object?> toJson() => {
        ID: id,
        ACCESS_TOKEN: accessToken,
        REFRESH_TOKEN: refreshToken,
      };

  factory TokenORM.fromJson(Map<String, dynamic> json) => TokenORM(
        id: (json['id'] ?? null),
        accessToken: (json['access_token'] ?? ""),
        refreshToken: (json['refresh_token'] ?? ""),
      );

  static Future<TokenORM> fromDTO(TokenDTO tokenDTO) async {
    return TokenORM(
      accessToken: tokenDTO.accessToken,
      refreshToken: tokenDTO.refreshToken,
    );
  }

  TokenORM copy({
    int? id,
    String? accessToken,
    String? refreshToken,
  }) =>
      TokenORM(
        id: id ?? this.id,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );
}
