import 'package:flutter/material.dart';
import 'package:systetica/screen/pagamentos/view/pagamento_page.dart';

class PagamentoWidget extends State<PagamentoPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Text("Pagamentos"),
      ),
    );
  }
}
