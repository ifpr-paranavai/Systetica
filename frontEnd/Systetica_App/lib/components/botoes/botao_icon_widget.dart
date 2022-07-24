import 'package:flutter/material.dart';

class BotaoIconWidget extends StatefulWidget {
  const BotaoIconWidget({
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
  _BotaoIconWidget createState() => _BotaoIconWidget();
}

class _BotaoIconWidget extends State<BotaoIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
        left: 35,
        right: 35,
      ),
      child: Container(
        width: widget.largura,
        height: 47,
        decoration: BoxDecoration(
          color: widget.corBotao,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              15,
            ),
          ),
          border: Border.all(
            color: widget.corBorda,
            width: 1,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: _buttonIcon(),
        ),
      ),
    );
  }

  TextButton _buttonIcon() {
    return TextButton.icon(
      label: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Text(
            widget.labelText,
            style: TextStyle(
              color: widget.corTexto,
              fontWeight: widget.fontWeight,
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
      onPressed: widget.onPressed,
      icon: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.image),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}
