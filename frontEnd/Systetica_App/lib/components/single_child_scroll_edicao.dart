import 'package:flutter/material.dart';

class SingleChildScrollEdicao extends StatefulWidget {
  const SingleChildScrollEdicao({
    Key? key,
    required this.opcoes,
    required this.widgetComponent,
  }) : super(key: key);

  final Widget opcoes;
  final Widget widgetComponent;

  @override
  State<SingleChildScrollEdicao> createState() =>
      _SingleChildScrollEdicaoState();
}

class _SingleChildScrollEdicaoState extends State<SingleChildScrollEdicao> {
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
          widget.opcoes,
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
