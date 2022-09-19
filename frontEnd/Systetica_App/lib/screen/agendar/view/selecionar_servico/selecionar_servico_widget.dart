import 'package:flutter/material.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart';
import 'package:systetica/screen/agendar/view/selecionar_servico/selecionar_servico_page.dart';

class SelecionarServicoWidget extends State<SelecionarServicoPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá mundo"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Press to open dialog"),
          onPressed: () => _showDialog(),
        ),
      ),
    );
  }

  void _showDialog() {
    showSlideDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.black,
      backgroundColor: Colors.blueGrey,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
        ),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: paints.length,
        itemBuilder: (builder, index) {
          return ListTile(
            title: Text(paints[index]),
            leading: const CircleAvatar(
              child: Text('Opá'),
            ),
          );
        },
      ),
    );
  }

  List<String> paints = [
    'Azul',
    'Amarelo',
    'Branco',
    'Verde',
    "Vermelho",
    "Cinza",
  ];
}
