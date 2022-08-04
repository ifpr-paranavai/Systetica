// ignore_for_file: file_names

import 'package:systetica/model/Estado.dart';

class Cidade {
  Cidade({
    required this.id,
    required this.nome,
    this.estado,
  });

  late final int id;
  late final String nome;
  Estado? estado;

  Cidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    estado = Estado.fromJson(json['estado']);
  }

  static List<Cidade> fromJsonList(List<dynamic> json) {
    var lista = <Cidade>[];

    for (var i = 0; i < json.length; i++) {
      lista.add(Cidade.fromJson(json[i]));
    }

    return lista;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['estado'] = estado?.toJson();
    return _data;
  }
}
