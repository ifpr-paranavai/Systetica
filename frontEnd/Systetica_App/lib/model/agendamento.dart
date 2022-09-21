// ignore_for_file: constant_identifier_names, file_names

import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/model/Usuario.dart';

class Agendamento {
  Agendamento({
    this.empresa,
    this.servicos,
    this.funcionario,
    this.usuario,
  });

  Empresa? empresa;
  List<Servico>? servicos;
  Usuario? funcionario;
  Usuario? usuario;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empresa'] = empresa;
    _data['servicos'] = servicos;
    _data['funcionario'] = funcionario;
    _data['usuario'] = usuario;
    return _data;
  }
}
