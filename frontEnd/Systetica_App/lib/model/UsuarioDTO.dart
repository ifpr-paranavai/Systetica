import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/model/RoleDTO.dart';

class UsuarioDTO {

  UsuarioDTO({
    this.id,
    this.nome,
    this.dataNascimento,
    this.cpf,
    this.telefone1,
    this.telefone2,
    this.email,
    this.password,
    this.codigoAleatorio,
    this.cidade,
    this.roles,
  });

  int? id;
  String? nome;
  String? dataNascimento;
  String? cpf;
  String? telefone1;
  String? telefone2;
  String? email;
  String? password;
  int? codigoAleatorio;
  CidadeDTO? cidade;
  List<RoleDTO>? roles;

  UsuarioDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataNascimento = json['data_nascimento'];
    cpf = json['cpf'];
    telefone1 = json['telefone1'];
    telefone2 = json['telefone2'];
    email = json['email'];
    password = json['password'];
    codigoAleatorio = json['codigo_aleatorio'];
    cidade = CidadeDTO.fromJson(json['cidade']);
    roles = json['roles'] != null
        ? (json['roles']
        .map<RoleDTO>((e) => RoleDTO.fromJson(e))).toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id ?? "";
    _data['nome'] = nome;
    _data['data_nascimento'] = dataNascimento;
    _data['cpf'] = cpf;
    _data['telefone1'] = telefone1;
    _data['telefone2'] = telefone2;
    _data['email'] = email;
    _data['password'] = password;
    _data['codigo_aleatorio'] = codigoAleatorio;
    _data['cidade'] = cidade?.toJson();
    _data['roles'] = roles != null ? roles!.map((e) => e.toString()).toList() : null;
    return _data;
  }
}
