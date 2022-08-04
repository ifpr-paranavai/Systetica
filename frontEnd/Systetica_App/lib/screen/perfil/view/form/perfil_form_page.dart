// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/Usuario.dart';
import 'package:systetica/screen/perfil/view/form/perfil_form_widget.dart';

class PerfilFormPage extends StatefulWidget {
  PerfilFormPage({Key? key, required this.usuario}) : super(key: key);
  Usuario? usuario;

  @override
  PerfilFormWidget createState() => PerfilFormWidget();
}
