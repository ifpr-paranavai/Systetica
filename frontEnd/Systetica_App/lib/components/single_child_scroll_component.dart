import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.3, 0.05),
          colors: [Colors.grey.withOpacity(0.4), Colors.white],
        ),
      ),
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
