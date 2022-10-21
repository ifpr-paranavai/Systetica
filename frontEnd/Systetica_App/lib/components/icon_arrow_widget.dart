// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors.dart';

class IconArrowWidget extends StatefulWidget {
  IconArrowWidget({
    Key? key,
    required this.onPressed,
    this.paddingTop = 0,
  }) : super(key: key);

  VoidCallback? onPressed;
  double paddingTop;

  @override
  _IconArrowWidget createState() => _IconArrowWidget();
}

class _IconArrowWidget extends State<IconArrowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.branco,
      padding: EdgeInsets.only(
        top: widget.paddingTop,
      ),
      child: IconButton(
        splashRadius: 22,
        icon: const Icon(
          Icons.keyboard_arrow_left_outlined,
          size: 35,
        ),
        color: Colors.black,
        onPressed: widget.onPressed,
      ),
    );
  }
}
