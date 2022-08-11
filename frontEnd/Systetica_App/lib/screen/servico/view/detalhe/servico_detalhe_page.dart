import 'package:flutter/cupertino.dart';
import 'package:systetica/model/Servico.dart';
import 'package:systetica/screen/servico/view/detalhe/servico_detalhe_widget.dart';

class ServicoDetalhePage extends StatefulWidget {
  ServicoDetalhePage({Key? key, required this.servico}) : super(key: key);
  Servico servico;

  @override
  ServicoDetalheWidget createState() => ServicoDetalheWidget();
}
