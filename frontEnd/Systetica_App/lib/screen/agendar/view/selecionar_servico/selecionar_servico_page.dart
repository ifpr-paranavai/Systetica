// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/screen/agendar/view/selecionar_servico/selecionar_servico_widget.dart';

class SelecionarServicoPage extends StatefulWidget {
  SelecionarServicoPage({Key? key, required this.empresa}) : super(key: key);
  Empresa empresa;

  @override
  SelecionarServicoWidget createState() => SelecionarServicoWidget();
}