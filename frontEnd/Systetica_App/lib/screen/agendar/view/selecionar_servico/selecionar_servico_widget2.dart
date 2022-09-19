import 'package:flutter/material.dart';

class SingleSelectionExample extends StatefulWidget {
  SingleSelectionExample();

  @override
  _SingleSelectionExampleState createState() => _SingleSelectionExampleState();
}

class _SingleSelectionExampleState extends State<SingleSelectionExample> {
  List<String> nomes = [
    'Franciel',
    'Pedro',
    'Marcelo',
    'Carlos',
    'Tiago',
  ];
  String nome = '';

  @override
  void initState() {
    super.initState();
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    double _largura = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Teste"),
      ),
      body: ListView.builder(
        itemCount: nomes.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  width: _largura * 0.5,
                  child: Text(
                    nomes[index] + '\nCorte de cabelo - 80 min',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  alignment: Alignment.centerRight,
                  width: _largura * 0.5,
                  child: Radio(
                    value: nomes[index],
                    groupValue: nome,
                    onChanged: (s) {
                      nome = s.toString();
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            onTap: () {
              nome = nomes[index];
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
