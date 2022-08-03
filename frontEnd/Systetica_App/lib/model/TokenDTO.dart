// ignore_for_file: file_names

import 'package:systetica/database/orm/token_orm.dart';
import 'package:systetica/utils/util.dart';

class TokenDTO {
  int? id;
  String? accessToken;
  String? refreshToken;
  String? email;
  String? dateTimeToken;

  TokenDTO({
    this.id,
    this.accessToken,
    this.refreshToken,
    this.email,
    this.dateTimeToken,
  });

  TokenDTO toDTO(TokenORM tokenORM) {
    TokenDTO tokenDTO = TokenDTO();
    tokenDTO.id = tokenORM.id;
    tokenDTO.accessToken = tokenORM.accessToken;
    tokenDTO.refreshToken = tokenORM.refreshToken;
    tokenDTO.email = tokenORM.email;
    tokenDTO.dateTimeToken = tokenORM.dateTimeToken;

    return tokenDTO;
  }

  TokenDTO.fromJson(Map<String, dynamic> json) {
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
