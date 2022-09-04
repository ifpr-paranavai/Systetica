// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class PesquisaWidget extends StatefulWidget {
  PesquisaWidget({
    required this.altura,
    required this.largura,
    required this.hintText,
    required this.onChanged,
    this.paddingLeft = 0.22,
    this.paddingRight = 0.037,
    Key? key,
  }) : super(key: key);

  double altura;
  double largura;
  double paddingLeft;
  double paddingRight;
  String hintText;
  ValueChanged<String> onChanged;

  @override
  _PesquisaWidget createState() => _PesquisaWidget();
}

class _PesquisaWidget extends State<PesquisaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.only(
        top: widget.largura * 0.040,
        bottom: widget.largura * 0.030,
        right: widget.largura * widget.paddingRight,
        left: widget.largura * widget.paddingLeft,
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: widget.largura / 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            // width: 0.15,
            width: 1,
          ),
        ),
        child: TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(.4),
              fontWeight: FontWeight.w600,
              fontSize: widget.largura / 22,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(.6),
            ),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
