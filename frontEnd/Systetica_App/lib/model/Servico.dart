// ignore_for_file: file_names

class Servico {
  Servico({
    this.id,
    this.nome,
    this.tempoServico,
    this.descricao,
    this.preco,
    this.status,
    this.emailAdministrativo,
  });

  int? id;
  String? nome;
  int? tempoServico;
  String? descricao;
  double? preco;
  bool? status;
  String? emailAdministrativo;

  Servico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    tempoServico = json['tempo_servico'];
    descricao = json['descricao'];
    preco = json['preco'];
    status = json['status'];
    emailAdministrativo = json['email_administrativo'];
  }

  static List<Servico> fromJsonList(List json) {
    return json.map((item) => Servico.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['tempo_servico'] = tempoServico;
    _data['descricao'] = descricao;
    _data['preco'] = preco;
    _data['status'] = status;
    _data['email_administrativo'] = emailAdministrativo;
    return _data;
  }
}
