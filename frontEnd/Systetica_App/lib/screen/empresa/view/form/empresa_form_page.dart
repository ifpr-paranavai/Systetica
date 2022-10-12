// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../model/Empresa.dart';
import 'empresa_form_widget.dart';

class EmpresaFormPage extends StatefulWidget {
  EmpresaFormPage({Key? key, required this.empresa}) : super(key: key);
  Empresa? empresa;

  @override
  EmpresaFormWidget createState() => EmpresaFormWidget();
}
