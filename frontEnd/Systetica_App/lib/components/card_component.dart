import 'package:flutter/material.dart';

class CardComponent extends StatefulWidget {
  const CardComponent({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  State<CardComponent> createState() => _CardComponent();
}

class _CardComponent extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 0.15,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            children: widget.children,
        ),
      ),
    );
  }
}
