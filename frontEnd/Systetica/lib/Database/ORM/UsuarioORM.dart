import 'package:systetica/model/UsuarioDTO.dart';

class UsuarioORM {
  static const String TABLE = "usuario";
  static const String ID = "id";
  static const String NOME = "nome";
  static const String DATA_NASCIMENTO = "data_nascimento";
  static const String CPF = "cpf";
  static const String TELEFONE1 = "telefone1";
  static const String TELEFONE2 = "telefone2";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";

  int? id;
  String? nome;
  String? dataNascimento;
  String? cpf;
  String? telefone1;
  String? telefone2;
  String? email;
  String? password;

  UsuarioORM({
    this.id,
    this.nome,
    this.dataNascimento,
    this.cpf,
    this.telefone1,
    this.telefone2,
    this.email,
    this.password,
  });

  Map<String, Object?> toJson() => {
        ID: id,
        NOME: nome,
        DATA_NASCIMENTO: dataNascimento,
        CPF: cpf,
        TELEFONE1: telefone1,
        TELEFONE2: telefone2,
        EMAIL: email,
        PASSWORD: password,
      };

  factory UsuarioORM.fromJson(Map<String, dynamic> json) => UsuarioORM(
        id: (json['id']),
        nome: (json['nome']),
        dataNascimento: (json['data_nascimento']),
        telefone1: (json['telefone1']),
        telefone2: (json['telefone2']),
        cpf: (json['cpf']),
        email: (json['email']),
        password: (json['password']),
      );

  static Future<UsuarioORM> fromDTO(UsuarioDTO usuario) async {
    return UsuarioORM(
      id: usuario.id,
      nome: usuario.nome,
      dataNascimento: usuario.dataNascimento,
      cpf: usuario.cpf,
      telefone1: usuario.telefone1,
      telefone2: usuario.telefone2,
      email: usuario.email,
      password: usuario.password,
    );
  }

  UsuarioORM copy({
    int? id,
    String? nome,
    String? dataNascimento,
    String? cpf,
    String? telefone1,
    String? telefone2,
    String? email,
    String? password,
  }) =>
      UsuarioORM(
        id: id,
        nome: nome,
        dataNascimento: dataNascimento,
        cpf: cpf,
        telefone1: telefone1,
        telefone2: telefone2,
        email: email,
        password: password,
      );
}
