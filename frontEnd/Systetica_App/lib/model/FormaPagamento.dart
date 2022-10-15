// ignore_for_file: file_names

class FormaPagamento {
  FormaPagamento({
    required this.id,
    required this.nome,
  });

  late final int id;
  late final String nome;

  FormaPagamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  static List<FormaPagamento> fromJsonList(List json) {
    return json.map((item) => FormaPagamento.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    return _data;
  }
}
