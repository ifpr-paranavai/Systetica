// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class Produto {
  Produto({
    this.id,
    this.nome,
    this.marca,
    this.precoCompra,
    this.precoVenda,
    this.quantEstoque,
    this.status,
    this.emailAdministrativo,
    this.quantidadeVendidaController,
  });

  int? id;
  String? nome;
  String? marca;
  double? precoCompra;
  double? precoVenda;
  int? quantEstoque;
  bool? status;
  String? emailAdministrativo;
  bool produtoSelecionado = false;
  TextEditingController? quantidadeVendidaController;


  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    marca = json['marca'];
    precoCompra = json['preco_compra'];
    precoVenda = json['preco_venda'];
    quantEstoque = json['quant_estoque'];
    status = json['status'];
    emailAdministrativo = json['email_administrativo'];
  }

  static List<Produto> fromJsonList(List json) {
    return json.map((item) => Produto.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['marca'] = marca;
    _data['preco_compra'] = precoCompra;
    _data['preco_venda'] = precoVenda;
    _data['quant_estoque'] = quantEstoque;
    _data['status'] = status;
    _data['email_administrativo'] = emailAdministrativo;
    _data['quantidade_vendida'] = quantidadeVendidaController;
    return _data;
  }
}
