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
    this.corBorda = Colors.transparent,
    this.paddingRight = 0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  final String labelText;
  final VoidCallback? onPressed;
  final double? largura;
  final Color corBotao;
  final Color corTexto;
  final Color corBorda;
  final double paddingTop;
  final double paddingBottom;
  final double paddingRight;
  final double fontSize;
  final FontWeight? fontWeight;

  @override
  _BotaoAcaoWidget createState() => _BotaoAcaoWidget();
}

class _BotaoAcaoWidget extends State<BotaoAcaoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
      ),
      child: Container(
        width: widget.largura,
        height: 47,
        decoration: BoxDecoration(
          color: widget.corBotao,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
          border: Border.all(
            color: widget.corBorda,
            width: 1,
          ),
        ),
        child: TextButton(
          child: Text(
            widget.labelText,
            style: TextStyle(
              color: widget.corTexto,
              fontWeight: widget.fontWeight,
              fontSize: widget.fontSize,
            ),
          ),
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
