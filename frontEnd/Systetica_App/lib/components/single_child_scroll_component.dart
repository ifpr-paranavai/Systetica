import 'package:flutter/material.dart';
import 'package:systetica/style/app_colors..dart';

class SingleChildScrollComponent extends StatefulWidget {
  const SingleChildScrollComponent({
    Key? key,
    required this.widgetComponent,
  }) : super(key: key);

  final Widget widgetComponent;

  @override
  State<SingleChildScrollComponent> createState() =>
      _SingleChildScrollComponentState();
}

class _SingleChildScrollComponentState extends State<SingleChildScrollComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.branco,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: widget.widgetComponent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
