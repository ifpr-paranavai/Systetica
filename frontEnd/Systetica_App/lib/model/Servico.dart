// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

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
  bool servicoSelecionado = false;

  Servico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    tempoServico = json['tempo_servico'];
    descricao = json['descricao'];
    preco = json['preco'];
    status = json['status'];
    emailAdministrativo = json['email_administrativo'];
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

  static List<Servico> fromJsonList(List json) {
    return json.map((item) => Servico.fromJson(item)).toList();
  }
  }
