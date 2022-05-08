import 'package:flutter/material.dart';

class BotaoAcaoWidget extends StatefulWidget {
  const BotaoAcaoWidget({
    Key? key,
    required this.labelText,
    this.onPressed,
    this.largura,
    required this.paddingTop,
    required this.paddingBottom,
    required this.corBotao,
    required this.corTexto,
  }) : super(key: key);

  final String labelText;
  final VoidCallback? onPressed;
  final double? largura;
  final Color corBotao;
  final Color corTexto;
  final double paddingTop;
  final double paddingBottom;

  @override
  _BotaoAcaoWidget createState() => _BotaoAcaoWidget();
}

class _BotaoAcaoWidget extends State<BotaoAcaoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: widget.paddingTop, bottom: widget.paddingBottom),
      child: Container(
        width: widget.largura,
        height: 47,
        padding: const EdgeInsets.only(
          bottom: 0,
          top: 0,
          left: 14,
          right: 14,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          color: widget.corBotao,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: TextButton(
          child: Text(
            widget.labelText,
            style: TextStyle(
              color: widget.corTexto,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
