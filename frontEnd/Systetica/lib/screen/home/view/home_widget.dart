import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:systetica/screen/agendamentos/view/agendamento_page.dart';
import 'package:systetica/screen/agendar/view/agendar_page.dart';
import 'package:systetica/screen/cadastros_administrador/view/cadastro_administrador_page.dart';
import 'package:systetica/screen/home/view/home_page.dart';
import 'package:systetica/screen/pagamentos/view/pagamento_page.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';
import 'package:systetica/style/app_colors..dart';

class HomeWidget extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> widgetOpcoes = <Widget>[];
  List<BottomNavigationBarItem> bottomNavigations = <BottomNavigationBarItem>[];

  @override
  void initState() {
    // TokenRepository.findToken().then((value) {
    setState(() {
      String mytokenTest =
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJydWFudmhhMTVAZ21haWwuY29tIiwicm9sZXMiOlsiQURNSU5JU1RSQURPUiJdLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwOTAvbG9naW4iLCJleHAiOjE2NTEyOTE3MTN9.FCOLo3ZUtr8i2pv8uXGij1Z16lcjW05hPRcTQd3Tz5w";

      Map<String, dynamic> tokenDecodificado = JwtDecoder.decode(mytokenTest);
      if (tokenDecodificado['roles'][0] == "ADMINISTRADOR") {
        widgetOpcoes = widgetOpcoesAdministrador;
        bottomNavigations = bottomNavigationAdministrador;
      } else if (tokenDecodificado['roles'][0] == "FUNCIONARIO") {
        widgetOpcoes = widgetOpcoesFuncionario;
        bottomNavigations = bottomNavigationFuncionario;
      } else {
        widgetOpcoes = widgetOpcoesCliente;
        bottomNavigations = bottomNavigationCliente;
      }
    });
    // });
    super.initState();
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
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: widgetOpcoes.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(12),
          height: screenWidth * .155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BottomNavigationBar(
              iconSize: 28,
              selectedItemColor: AppColors.redPrincipal,
              unselectedItemColor: AppColors.bluePrincipal,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _selectedIndex,
              items: bottomNavigations,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

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

  List<BottomNavigationBarItem> get bottomNavigationCliente {
    List<BottomNavigationBarItem> bottomNavigatrion =
        const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.schedule),
        label: 'Agedar',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: 'Agendamentos',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        label: 'Perfil',
      ),
    ];
    return bottomNavigatrion;
  }

  List<BottomNavigationBarItem> get bottomNavigationFuncionario {
    List<BottomNavigationBarItem> bottomNavigatrion =
        const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.schedule),
        label: 'Agedar',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on),
        label: 'Pagamento',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: 'Agendamentos',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        label: 'Perfil',
      ),
    ];
    return bottomNavigatrion;
  }

  List<BottomNavigationBarItem> get bottomNavigationAdministrador {
    List<BottomNavigationBarItem> bottomNavigatrion =
        const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.schedule),
        label: 'Agedar',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on),
        label: 'Pagamento',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: 'Agendamentos',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.create_new_folder),
        label: 'Cadastros',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        label: 'Perfil',
      ),
    ];
    return bottomNavigatrion;
  }
}
