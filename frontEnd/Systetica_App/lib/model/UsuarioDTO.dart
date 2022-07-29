import 'package:systetica/model/RoleDTO.dart';

class UsuarioDTO {
  UsuarioDTO({
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
  List<RoleDTO>? roles;
  String? imagemBase64;

  UsuarioDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    telefone = json['telefone'];
    email = json['email'];
    password = json['password'];
    codigoAleatorio = json['codigo_aleatorio'];
    roles = json['roles'] != null
        ? (json['roles'].map<RoleDTO>((e) => RoleDTO.fromJson(e))).toList()
        : [];
    imagemBase64 = json['imagemBase64'];
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
    _data['imagemBase64'] = imagemBase64;
    return _data;
  }
}
