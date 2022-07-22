class TokenDTO {
  String? accessToken;
  String? refreshToken;
  String? dateTimeToken;

  TokenDTO({
    this.accessToken,
    this.refreshToken,
    this.dateTimeToken,
  });

  TokenDTO.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    dateTimeToken = DateTime.now().toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    _data['refresh_token'] = refreshToken;
    _data['date_time_token'] = dateTimeToken;
    return _data;
  }
}
