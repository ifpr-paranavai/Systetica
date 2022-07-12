import 'package:flutter/material.dart';
import 'package:systetica/screen/agendamentos/view/agendamento_page.dart';
import 'package:systetica/screen/agendar/view/agendar_page.dart';
import 'package:systetica/screen/cadastro_usuario/view/cadastro/cadastro_page.dart';
import 'package:systetica/screen/cadastros_administrador/view/cadastro_administrador_page.dart';
import 'package:systetica/screen/home/view/home_page.dart';
import 'package:systetica/screen/pagamentos/view/pagamento_page.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';

class HomeWidget extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> get widgetOpcoesCliente {
    List<Widget> widgets = <Widget>[
      const AgendarPage(),
      const AgendamentoPage(),
      const PerfilPage(),
    ];
    return widgets;
  }

  List<Widget> get widgetOpcoesFuncionario {
    List<Widget> widgets = <Widget>[
      const AgendarPage(),
      const PagamentoPage(),
      const AgendamentoPage(),
      const PerfilPage(),
    ];
    return widgets;
  }

  List<Widget> get widgetOpcoesAdministrador {
    List<Widget> widgets = <Widget>[
      const AgendarPage(),
      const PagamentoPage(),
      const AgendamentoPage(),
      const CadastroAdministradorPage(),
      const PerfilPage(),
    ];
    return widgets;
  }

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: widgetOpcoesAdministrador.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: 'Agendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: 'Pagamento',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Agendamentos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Cadastros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
