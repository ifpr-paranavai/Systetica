// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextAutenticacoesWidget extends StatefulWidget {
  TextAutenticacoesWidget({
    Key? key,
    required this.text,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.paddingLeft = 35,
    this.paddingRight = 0,
    this.fontSize = 37,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  String text;
  double paddingTop;
  double paddingBottom;
  double paddingLeft;
  double paddingRight;
  double fontSize;
  AlignmentGeometry alignment;

  @override
  _TextAutenticacoesWidget createState() => _TextAutenticacoesWidget();
}

class _TextAutenticacoesWidget extends State<TextAutenticacoesWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Padding(
        padding: EdgeInsets.only(
          left: widget.paddingLeft,
          right: widget.paddingRight,
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
