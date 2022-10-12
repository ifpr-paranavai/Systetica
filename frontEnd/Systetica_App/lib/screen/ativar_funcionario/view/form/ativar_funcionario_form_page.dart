// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/Usuario.dart';
import 'ativar_funcionario_form_widget.dart';

class AtivarFuncionarioFormPage extends StatefulWidget {
  AtivarFuncionarioFormPage({Key? key, this.usuario}) : super(key: key);
  Usuario? usuario;

  @override
  AtivarFuncionarioFormWidget createState() => AtivarFuncionarioFormWidget();
}