// ignore_for_file: file_names

import 'package:systetica/model/Cidade.dart';
import 'package:systetica/model/Usuario.dart';

class Empresa {
  Empresa({
    this.id,
    this.nome,
    this.cnpj,
    this.telefone1,
    this.telefone2,
    this.endereco,
    this.numero,
    this.cep,
    this.bairro,
    this.latitude,
    this.longitude,
    this.logoBase64,
    this.cidade,
    this.usuarioAdministrador,
    this.nomeUsuario,
  });

  int? id;
  String? nome;
  String? cnpj;
  String? telefone1;
  String? telefone2;
  String? endereco;
  int? numero;
  String? cep;
  String? bairro;
  String? latitude;
  String? longitude;
  String? logoBase64;
  Cidade? cidade;
  Usuario? usuarioAdministrador;
  String? nomeUsuario;

  Empresa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cnpj = json['cnpj'];
    telefone1 = json['telefone1'];
    telefone2 = json['telefone2'];
    endereco = json['endereco'];
    numero = json['numero'];
    cep = json['cep'];
    bairro = json['bairro'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    logoBase64 = json['logo_base64'];
    cidade = Cidade.fromJson(json['cidade']);
    nomeUsuario = json['nome_usuario'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = nome;
    _data['cnpj'] = cnpj;
    _data['telefone1'] = telefone1;
    _data['telefone2'] = telefone2;
    _data['endereco'] = endereco;
    _data['numero'] = numero;
    _data['cep'] = cep;
    _data['bairro'] = bairro;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['logo_base64'] = logoBase64;
    _data['cidade'] = cidade?.toJson();
    _data['usuario_administrador'] = usuarioAdministrador?.toJson();
    _data['nome_usuario'] = nomeUsuario;
    return _data;
  }
}
