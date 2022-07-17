import 'package:flutter/material.dart';

class IconArrowWidget extends StatefulWidget {
  IconArrowWidget({
    Key? key,
    required this.onPressed,
    this.paddingTop = 0,
    this.paddingBotton = 0,
  }) : super(key: key);

  VoidCallback? onPressed;
  double paddingTop;
  double paddingBotton;

  @override
  _IconArrowWidget createState() => _IconArrowWidget();
}

class _IconArrowWidget extends State<IconArrowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.paddingTop,
        bottom: widget.paddingBotton
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 35,
          ),
          color: Colors.black,
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
