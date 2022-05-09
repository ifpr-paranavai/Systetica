import 'package:systetica/model/EstadoDTO.dart';

class CidadeDTO {
  CidadeDTO({
    required this.id,
    required this.nome,
    this.estado,
  });

  late final int id;
  late final String nome;
  EstadoDTO? estado;

  CidadeDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    estado = EstadoDTO.fromJson(json['estado']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['estado'] = estado?.toJson();
    return _data;
  }
}
