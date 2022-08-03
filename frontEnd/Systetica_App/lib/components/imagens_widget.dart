// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ImagensWidget extends StatefulWidget {
  ImagensWidget({
    Key? key,
    required this.image,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.paddingTop = 0,
    required this.widthImagem,
  }) : super(key: key);

  String image;
  double paddingLeft;
  double paddingTop;
  double paddingBottom;
  double? widthImagem;

  @override
  _ImagensWidget createState() => _ImagensWidget();
}

class _ImagensWidget extends State<ImagensWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        left: widget.paddingLeft,
        bottom: widget.paddingBottom,
      ),
      child: Image.asset(
        'assets/img/${widget.image}',
        fit: BoxFit.cover,
        width: widget.widthImagem,
      ),
    );
  }
}
