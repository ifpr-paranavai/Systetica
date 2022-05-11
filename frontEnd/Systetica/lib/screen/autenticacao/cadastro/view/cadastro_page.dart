import 'package:flutter/material.dart';
import 'package:systetica/model/CidadeDTO.dart';
import 'package:systetica/screen/autenticacao/cadastro/view/cadastro_widget.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({
    Key? key,
    required this.cidades
  }) : super(key: key);

  final List<CidadeDTO> cidades;

  @override
  // ignore: no_logic_in_create_state
  CadastroWidget createState() => CadastroWidget(cidades: cidades);
}