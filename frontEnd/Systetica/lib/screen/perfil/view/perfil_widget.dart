import 'package:flutter/material.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';

class PerfilWidget extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: Text("Perfil"),
      ),
    );
  }
}
