import 'package:flutter/material.dart';

class TextAutenticacoesWidget extends StatefulWidget {
  TextAutenticacoesWidget({
    Key? key,
    required this.text,
    this.paddingTop = 0,
    this.paddingBottom = 0,
  }) : super(key: key);

  String text;
  double paddingTop;
  double paddingBottom;

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
          left: 35,
          top: widget.paddingTop,
          bottom: widget.paddingBottom,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.black87.withOpacity(0.9),
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}
