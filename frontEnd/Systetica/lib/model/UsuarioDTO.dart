import 'package:systetica/Database/ORM/UsuarioORM.dart';

class UsuarioDTO {

  UsuarioDTO({
    this.id,
    required this.nome,
    required this.dataNascimento,
    required this.cpf,
    required this.telefone1,
    this.telefone2,
    required this.email,
    required this.password,
  });

  UsuarioDTO.empty();

  int? id;
  late final String nome;
  late final String dataNascimento;
  late final String cpf;
  late final String telefone1;
  String? telefone2;
  late final String email;
  late final String password;

  static UsuarioDTO fromDTO(UsuarioORM usuarioORM) {
    return UsuarioDTO(
      id: usuarioORM.id,
      nome: usuarioORM.nome!,
      dataNascimento: usuarioORM.dataNascimento!,
      cpf: usuarioORM.cpf!,
      telefone1: usuarioORM.telefone1!,
      telefone2: usuarioORM.telefone2!,
      email: usuarioORM.email!,
      password: usuarioORM.password!,
    );
  }

  UsuarioDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataNascimento = json['data_nascimento'];
    cpf = json['cpf'];
    telefone1 = json['telefone1'];
    telefone2 = json['telefone2'];
    email = json['email'];
    password = json['password'];
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
    return _data;
  }
}
