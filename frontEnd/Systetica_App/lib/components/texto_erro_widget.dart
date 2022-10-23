import 'package:flutter/material.dart';

class TextoErroWidget extends StatefulWidget {
  const TextoErroWidget({
    Key? key,
    required this.mensagem,
  }) : super(key: key);
  final String? mensagem;

  @override
  _TextoErroWidget createState() => _TextoErroWidget();
}

class _TextoErroWidget extends State<TextoErroWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.mensagem!,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
