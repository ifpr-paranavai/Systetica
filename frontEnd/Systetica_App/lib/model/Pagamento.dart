// ignore_for_file: file_names

import 'FormaPagamento.dart';

class Pagamento {
  Pagamento({
    this.id,
    this.valorTotal,
    this.desconto,
    this.formaPagamento,
  });

  int? id;
  double? valorTotal;
  double? desconto;
  FormaPagamento? formaPagamento;

  Pagamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valorTotal = json['valor_total'];
    desconto = json['desconto'];
    formaPagamento = json['forma_pagamento'];
  }

  static List<Pagamento> fromJsonList(List json) {
    return json.map((item) => Pagamento.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['valor_total'] = valorTotal;
    _data['desconto'] = desconto;
    _data['forma_pagamento'] = formaPagamento;
    return _data;
  }
}
