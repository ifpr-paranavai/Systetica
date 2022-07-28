import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors..dart';

class BotaoWidget extends StatefulWidget {
  const BotaoWidget({
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
    this.overlayColor = AppColors.blue5,
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
  final Color overlayColor;

  @override
  _BotaoWidget createState() => _BotaoWidget();
}

class _BotaoWidget extends State<BotaoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBottom,
      ),
      child: SizedBox(
        width: widget.largura,
        height: 47,
        child: _textButton(),
      ),
    );
  }

  TextButton _textButton() {
    return TextButton(
      child: Text(
        widget.labelText,
        style: TextStyle(
          color: widget.corTexto,
          fontWeight: widget.fontWeight,
          fontSize: widget.fontSize,
        ),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(widget.overlayColor),
        backgroundColor: MaterialStateProperty.all(widget.corBotao),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
            side: BorderSide(
              color: widget.corBorda,
              width: 1,
            ),
          ),
        ),
      ),
      onPressed: widget.onPressed,
    );
  }
}
