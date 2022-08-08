class BrasilCep {
  BrasilCep({this.rua, this.bairro, this.local});

  String? rua;
  String? bairro;
  Local? local;

  BrasilCep.fromJson(Map<String, dynamic> json) {
    rua = json['street'];
    bairro = json['neighborhood'];
    local = Local.fromJson(json['location']);
  }
}

class Local {
  Local(this.cordenada);

  Coordenada? cordenada;

  Local.fromJson(Map<String, dynamic> json) {
    cordenada = Coordenada.fromJson(json['coordinates']);
  }
}

class Coordenada {
  Coordenada(this.longitude, this.latitude);

  String? longitude;
  String? latitude;

  Coordenada.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
}
