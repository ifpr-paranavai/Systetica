// ignore_for_file: file_names

class Estado {
  Estado({
    required this.id,
    required this.nome,
    required this.uf,
  });

  late final int id;
  late final String nome;
  late final String uf;

  Estado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['uf'] = uf;
    return _data;
  }
}
