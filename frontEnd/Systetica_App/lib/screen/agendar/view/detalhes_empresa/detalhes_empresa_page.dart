// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/screen/agendar/view/detalhes_empresa/detalhes_empresa_widget.dart';

class DetalhaEmpresaPage extends StatefulWidget {
  DetalhaEmpresaPage({Key? key, required this.empresa}) : super(key: key);
  Empresa empresa;

  @override
  DetalhaEmpresaWidget createState() => DetalhaEmpresaWidget();
}
