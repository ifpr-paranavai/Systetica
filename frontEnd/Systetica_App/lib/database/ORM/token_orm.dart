// ignore_for_file: constant_identifier_names

import 'package:systetica/model/TokenDTO.dart';

class TokenORM {
  static const String TABLE = "token";
  static const String ID = "id";
  static const String ACCESS_TOKEN = "access_token";
  static const String REFRESH_TOKEN = "refresh_token";
  static const String EMAIL = "email";
  static const String DATE_TIME_TOKEN = "date_time_token";

  int? id;
  String? accessToken;
  String? refreshToken;
  String? email;
  String? dateTimeToken;

  TokenORM({
    this.id,
    this.accessToken,
    this.refreshToken,
    this.email,
    this.dateTimeToken,
  });

  Map<String, Object?> toJson() => {
        ID: id,
        ACCESS_TOKEN: accessToken,
        REFRESH_TOKEN: refreshToken,
        EMAIL: email,
        DATE_TIME_TOKEN: dateTimeToken,
      };

  factory TokenORM.fromJson(Map<String, dynamic> json) => TokenORM(
        id: (json['id']),
        accessToken: (json['access_token'] ?? ""),
        refreshToken: (json['refresh_token'] ?? ""),
        email: (json['email'] ?? ""),
        dateTimeToken: (json['data_time_token'] ?? ""),
      );

  static Future<TokenORM> fromDTO(TokenDTO tokenDTO) async {
    return TokenORM(
      accessToken: tokenDTO.accessToken,
      refreshToken: tokenDTO.refreshToken,
      email: tokenDTO.email,
      dateTimeToken: tokenDTO.dateTimeToken,
    );
  }

  TokenORM copy({
    int? id,
    String? accessToken,
    String? refreshToken,
    String? email,
    String? dateTimeToken,
  }) =>
      TokenORM(
        id: id ?? this.id,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        email: email ?? this.email,
        dateTimeToken: dateTimeToken ?? this.dateTimeToken,
      );
}
