import 'package:flutter/material.dart';

class GestureDetectorComponent extends StatefulWidget {
  const GestureDetectorComponent({
    Key? key,
    required this.largura,
    required this.textNome,
    required this.groupValue,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  final double largura;
  final String textNome;
  final String groupValue;
  final ValueChanged<dynamic>? onChanged;
  final GestureTapCallback? onTap;

  @override
  State<GestureDetectorComponent> createState() => _GestureDetectorComponent();
}

class _GestureDetectorComponent extends State<GestureDetectorComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            //TODO -COMPONENTE DE CONTAINER
            padding: const EdgeInsets.only(
              left: 15,
            ),
            width: widget.largura * 0.5,
            height: 40,
            child: Text(
              widget.textNome,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            alignment: Alignment.centerRight,
            width: widget.largura * 0.5,
            height: 40,
            child: Radio(
              value: widget.textNome,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
      onTap: widget.onTap,
    );
  }
}
