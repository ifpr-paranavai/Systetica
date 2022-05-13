class TokenDTO {
  TokenDTO({
    this.accessToken,
    this.refreshToken,
  });
  
  String? accessToken;
  String? refreshToken;

  TokenDTO.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    _data['refresh_token'] = refreshToken;
    return _data;
  }
}
