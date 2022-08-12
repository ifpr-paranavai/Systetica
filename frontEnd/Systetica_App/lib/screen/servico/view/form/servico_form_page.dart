// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/servico/view/form/servico_form_widget.dart';

class ServicoFormPage extends StatefulWidget {
  ServicoFormPage({Key? key, this.servico}) : super(key: key);
  Servico? servico;

  @override
  ServicoFormWidget createState() => ServicoFormWidget();
}