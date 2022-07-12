import 'package:flutter/material.dart';
import 'package:systetica/screen/agendar/view/agendar_page.dart';

class AgendarlWidget extends State<AgendarPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Text("Agendamento"),
      ),
    );
  }
}
