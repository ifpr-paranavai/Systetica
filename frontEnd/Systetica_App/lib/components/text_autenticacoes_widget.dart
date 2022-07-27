import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextAutenticacoesWidget extends StatefulWidget {
  TextAutenticacoesWidget({
    Key? key,
    required this.text,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.paddingLeft = 35,
    this.fontSize = 37,
  }) : super(key: key);

  String text;
  double paddingTop;
  double paddingBottom;
  double paddingLeft;
  double fontSize;

  @override
  _TextAutenticacoesWidget createState() => _TextAutenticacoesWidget();
}

class _TextAutenticacoesWidget extends State<TextAutenticacoesWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: widget.paddingLeft,
          top: widget.paddingTop,
          bottom: widget.paddingBottom,
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.amaticSc(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black87.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
