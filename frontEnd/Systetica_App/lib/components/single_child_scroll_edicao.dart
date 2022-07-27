import 'package:flutter/material.dart';

class SingleChildScrollEdicao extends StatefulWidget {
  const SingleChildScrollEdicao({
    Key? key,
    required this.widgetComponent,
  }) : super(key: key);

  final Widget widgetComponent;

  @override
  State<SingleChildScrollEdicao> createState() =>
      _SingleChildScrollEdicaoState();
}

class _SingleChildScrollEdicaoState extends State<SingleChildScrollEdicao> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: const Alignment(0.1, 0.05),
            colors: [Colors.grey.withOpacity(0.4), Colors.white],
          ),
        ),
        child: widget.widgetComponent,
      ),
    );
  }
}
