// ignore_for_file: file_names

import 'package:systetica/model/Estado.dart';

class Cidade {
  Cidade({
    this.id,
    this.nome,
    this.estado,
  });

  int? id;
  String? nome;
  Estado? estado;

  Cidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    estado = Estado.fromJson(json['estado']);
  }

  static List<Cidade> fromJsonList(List json) {
    return json.map((item) => Cidade.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['estado'] = estado?.toJson();
    return _data;
  }
}
