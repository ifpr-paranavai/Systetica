// ignore_for_file: file_names

class Situacao {
  Situacao({
    required this.id,
    required this.nome,
  });

  late final int id;
  late final String nome;

  Situacao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    return _data;
  }
}
