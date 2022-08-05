// ignore_for_file: file_names

import 'package:systetica/model/Role.dart';

class Usuario {
  Usuario({
    this.id,
    this.nome,
    this.telefone,
    this.email,
    this.password,
    this.codigoAleatorio,
    this.roles,
    this.imagemBase64,
  });

  int? id;
  String? nome;
  String? telefone;
  String? email;
  String? password;
  int? codigoAleatorio;
  List<Role>? roles;
  String? imagemBase64;

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    email = json['email'];
    password = json['password'];
    codigoAleatorio = json['codigo_aleatorio'];
    roles = json['roles'] != null
        ? (json['roles'].map<Role>((e) => Role.fromJson(e))).toList()
        : [];
    imagemBase64 = json['imagem_base64'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id ?? "";
    _data['nome'] = nome;
    _data['telefone'] = telefone;
    _data['email'] = email;
    _data['password'] = password;
    _data['password'] = password;
    _data['codigo_aleatorio'] = codigoAleatorio;
    _data['roles'] =
        roles != null ? roles!.map((e) => e.toString()).toList() : null;
    _data['imagem_base64'] = imagemBase64;
    return _data;
  }
}