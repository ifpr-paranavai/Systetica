import 'package:flutter/material.dart';
import 'package:systetica/screen/home/view/home_page.dart';

class HomeWidget extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bem vindo"
        ),
      ),
      body: const Center(
        child: Text(
          "Tela em Construção"
        ),
      ),
    );
  }

}