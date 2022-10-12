// ignore_for_file: file_names

import '../database/ORM/token_orm.dart';
import '../utils/util.dart';

class Token {
  int? id;
  String? accessToken;
  String? refreshToken;
  String? email;
  String? dateTimeToken;

  Token({
    this.id,
    this.accessToken,
    this.refreshToken,
    this.email,
    this.dateTimeToken,
  });

  Token toDTO(TokenORM tokenORM) {
    Token token = Token();
    token.id = tokenORM.id;
    token.accessToken = tokenORM.accessToken;
    token.refreshToken = tokenORM.refreshToken;
    token.email = tokenORM.email;
    token.dateTimeToken = tokenORM.dateTimeToken;

    return token;
  }

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    email = accessToken == null ? null : Util.emailDecode(accessToken!);
    dateTimeToken = json['date_time_token'] ?? DateTime.now().toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['access_token'] = accessToken;
    _data['refresh_token'] = refreshToken;
    _data['email'] = email;
    _data['date_time_token'] = dateTimeToken;
    return _data;
  }
}
