// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'gerar_codigo_widget.dart';

class GerarCodigoPage extends StatefulWidget {
  GerarCodigoPage({Key? key, this.reenviarCodigo = false}) : super(key: key);
  bool reenviarCodigo;

  @override
  GerarCodigoWidget createState() => GerarCodigoWidget();
}
