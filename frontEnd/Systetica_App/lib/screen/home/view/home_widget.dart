import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../database/repository/token_repository.dart';
import '../../../style/app_colors.dart';
import '../../administrador/view/administrador_page.dart';
import '../../agendamentos/view/agendamento/agendamento_page.dart';
import '../../agendar/view/detalhes_empresa/detalhes_empresa_page.dart';
import '../../pagamento/view/pagamento_page.dart';
import '../../perfil/view/perfil_page.dart';
import 'home_page.dart';

class HomeWidget extends State<HomePage> {
  late int _selectedIndex = 0;

  List<Widget> _widgetOpcoes = <Widget>[];
  List<BottomNavigationBarItem> _bottomNavigations =
      <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();
    _widgetOpcoes = _widgetOpcoesCliente;
    _bottomNavigations = _bottomNavigationCliente;
    _buscarTokenLocal();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        body: Center(
          child: _widgetOpcoes.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          height: screenWidth * .159,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.black,
              width: 0.17,
            ),
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
              items: _bottomNavigations,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _buscarTokenLocal() async {
    await TokenRepository.findToken().then((value) {
      setState(() {
        Map<String, dynamic> tokenDecodificado =
            JwtDecoder.decode(value.accessToken!);
        if (tokenDecodificado['roles'][0] == "ADMINISTRADOR") {
          _widgetOpcoes = _widgetOpcoesAdministrador;
          _bottomNavigations = _bottomNavigationAdministrador;
        } else if (tokenDecodificado['roles'][0] == "FUNCIONARIO") {
          _widgetOpcoes = _widgetOpcoesFuncionario;
          _bottomNavigations = _bottomNavigationFuncionario;
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

  List<Widget> get _widgetOpcoesCliente {
    List<Widget> widgets = <Widget>[
      const DetalhaEmpresaPage(),
      const AgendamentoPage(),
      const PerfilPage(),
    ];
    return widgets;
  }

  List<Widget> get _widgetOpcoesFuncionario {
    List<Widget> widgets = <Widget>[
      const AgendamentoPage(),
      const PagamentoPage(),
      const PerfilPage(),
    ];
    return widgets;
  }

  List<Widget> get _widgetOpcoesAdministrador {
    List<Widget> widgets = <Widget>[
      const AgendamentoPage(),
      const PagamentoPage(),
      const CadastroAdministradorPage(),
      const PerfilPage(),
    ];
    return widgets;
  }

  List<BottomNavigationBarItem> get _bottomNavigationCliente {
    List<BottomNavigationBarItem> bottomNavigatrion = <BottomNavigationBarItem>[
      _bottomAgendar(),
      _bottomAgendamentos(),
      _bottomPerfil(),
    ];
    return bottomNavigatrion;
  }

  List<BottomNavigationBarItem> get _bottomNavigationFuncionario {
    List<BottomNavigationBarItem> bottomNavigatrion = <BottomNavigationBarItem>[
      _bottomAgendamentos(),
      _bottomPagamentos(),
      _bottomPerfil(),
    ];
    return bottomNavigatrion;
  }

  List<BottomNavigationBarItem> get _bottomNavigationAdministrador {
    List<BottomNavigationBarItem> bottomNavigatrion = <BottomNavigationBarItem>[
      _bottomAgendamentos(),
      _bottomPagamentos(),
      _bottomCadastros(),
      _bottomPerfil(),
    ];
    return bottomNavigatrion;
  }

  BottomNavigationBarItem _bottomAgendar() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.schedule),
      label: 'Agedar',
    );
  }

  BottomNavigationBarItem _bottomPagamentos() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.monetization_on),
      label: 'Pagamento',
    );
  }

  BottomNavigationBarItem _bottomAgendamentos() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'Agendamentos',
    );
  }

  BottomNavigationBarItem _bottomCadastros() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.create_new_folder),
      label: 'Cadastros',
    );
  }

  BottomNavigationBarItem _bottomPerfil() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Perfil',
    );
  }
}
