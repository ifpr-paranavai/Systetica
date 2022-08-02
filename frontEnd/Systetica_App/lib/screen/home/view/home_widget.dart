import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:systetica/database/repository/token_repository.dart';
import 'package:systetica/screen/agendamentos/view/agendamento_page.dart';
import 'package:systetica/screen/agendar/view/agendar_page.dart';
import 'package:systetica/screen/cadastros_administrador/view/cadastro_administrador_page.dart';
import 'package:systetica/screen/home/view/home_page.dart';
import 'package:systetica/screen/pagamentos/view/pagamento_page.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';
import 'package:systetica/style/app_colors..dart';

class HomeWidget extends State<HomePage> {
  late int _selectedIndex = 0;

  List<Widget> widgetOpcoes = <Widget>[];
  List<BottomNavigationBarItem> bottomNavigations = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();
    widgetOpcoes = widgetOpcoesCliente;
    bottomNavigations = bottomNavigationCliente;
    buscarTokenLocal();
  }

  Future<void> buscarTokenLocal() async {
    await TokenRepository.findToken().then((value) {
      setState(() {
        Map<String, dynamic> tokenDecodificado =
            JwtDecoder.decode(value.accessToken!);
        if (tokenDecodificado['roles'][0] == "ADMINISTRADOR") {
          widgetOpcoes = widgetOpcoesAdministrador;
          bottomNavigations = bottomNavigationAdministrador;
        } else if (tokenDecodificado['roles'][0] == "FUNCIONARIO") {
          widgetOpcoes = widgetOpcoesFuncionario;
          bottomNavigations = bottomNavigationFuncionario;
        }
      });
    });
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
        backgroundColor: Colors.white,
        body: Center(
          child: widgetOpcoes.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          height: screenWidth * .159,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.black,
              width: 0.15,
            ),
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
              iconSize: 26,
              selectedItemColor: AppColors.redPrincipal,
              unselectedItemColor: AppColors.bluePrincipal,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              enableFeedback: false,
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
    List<BottomNavigationBarItem> bottomNavigatrion = <BottomNavigationBarItem>[
      bottomAgendar(),
      bottomAgendamentos(),
      bottomPerfil(),
    ];
    return bottomNavigatrion;
  }

  List<BottomNavigationBarItem> get bottomNavigationFuncionario {
    List<BottomNavigationBarItem> bottomNavigatrion = <BottomNavigationBarItem>[
      bottomAgendar(),
      bottomPagamentos(),
      bottomAgendamentos(),
      bottomPerfil(),
    ];
    return bottomNavigatrion;
  }

  List<BottomNavigationBarItem> get bottomNavigationAdministrador {
    List<BottomNavigationBarItem> bottomNavigatrion = <BottomNavigationBarItem>[
      bottomAgendar(),
      bottomPagamentos(),
      bottomAgendamentos(),
      bottomCadastros(),
      bottomPerfil(),
    ];
    return bottomNavigatrion;
  }

  BottomNavigationBarItem bottomAgendar() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.schedule),
      label: 'Agedar',
    );
  }

  BottomNavigationBarItem bottomPagamentos() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on),
      label: 'Pagamento',
    );
  }

  BottomNavigationBarItem bottomAgendamentos() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Agendamentos',
    );
  }

  BottomNavigationBarItem bottomCadastros() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.create_new_folder),
      label: 'Cadastros',
    );
  }

  BottomNavigationBarItem bottomPerfil() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Perfil',
    );
  }
}
