import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/model/Empresa.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/screen/administrador/view/administrador_page.dart';
import 'package:systetica/screen/ativar_funcionario/view/ativar_funcionario_page.dart';
import 'package:systetica/screen/empresa/empresa_controller.dart';
import 'package:systetica/screen/empresa/view/empresa_page.dart';
import 'package:systetica/screen/produto/view/produto_page.dart';
import 'package:systetica/screen/servico/view/servico_page.dart';
import 'package:systetica/style/app_colors..dart';

class CadastroAdministradorWidget extends State<CadastroAdministradorPage>
    with SingleTickerProviderStateMixin {
  final EmpresaController _empresaController = EmpresaController();
  final _myPageTransition = MyPageTransition();

  late AnimationController _animationControllercontroller;

  final String _bemVindo = "Bem vindo";

  @override
  void initState() {
    super.initState();

    _animationControllercontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _animationControllercontroller.forward();
    _empresaController.empresa = Empresa();
  }

  @override
  void dispose() {
    super.dispose();
    _animationControllercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _largura = MediaQuery.of(context).size.width;
    double _altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Info?>(
          future: _empresaController.buscarEmpresaEmail(context),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else if (snapShot.hasData && snapShot.data!.success!) {
              _empresaController.empresa = snapShot.data!.object;
              return body(
                altura: _altura,
                largura: _largura,
                empresa: _empresaController.empresa.nome!,
                nomeUsuario: _empresaController.empresa.nomeUsuario!,
              );
            } else {
              return body(
                altura: _altura,
                largura: _largura,
              );
            }
          },
        ),
      ),
    );
  }

  Widget body({
    required double largura,
    required double altura,
    String? empresa,
    String? nomeUsuario,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _infoGerais(
            titulo: empresa ?? "Por favor, cadastre sua empresa.",
            descricao: _bemVindo +
                (nomeUsuario == null ? "!" : " " + nomeUsuario + "!"),
            widthSize: largura,
          ),
          SizedBox(
            height: altura * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _grupoCards(
                  title: "Empresa",
                  icon: Icons.account_balance,
                  color: AppColors.bluePrincipal,
                  route: const EmpresaPage(),
                  title2: 'Serviços',
                  icon2: Icons.construction,
                  color2: Colors.lightGreen,
                  route2: const ServicoPage(),
                  largura: largura,
                  altura: altura,
                  context: context,
                ),
                _grupoCards(
                  title: "Produtos",
                  icon: Icons.add_shopping_cart,
                  color: AppColors.redPrincipal,
                  route: const ProdutoPage(),
                  title2: 'Ativar Funcionário',
                  icon2: Icons.person,
                  color2: Colors.black,
                  route2: const AtivarFuncionarioPage(),
                  largura: largura,
                  altura: altura,
                  context: context,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _infoGerais({
    required String titulo,
    required String descricao,
    required double widthSize,
  }) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(
        left: widthSize * 0.07,
        top: widthSize * 0.05,
        bottom: widthSize * 0.06,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tituloSystetica(
            text: titulo,
            fonteSize: 27,
            opacity: 0.6,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: widthSize * 0.04),
          _tituloSystetica(
            text: descricao,
            fonteSize: 19,
            opacity: 0.5,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Text _tituloSystetica({
    required String text,
    required double fonteSize,
    required double opacity,
    required FontWeight? fontWeight,
  }) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fonteSize,
        color: Colors.black.withOpacity(opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Padding _grupoCards({
    required Color color,
    required IconData icon,
    required String title,
    required Widget route,
    required Color color2,
    required IconData icon2,
    required String title2,
    required Widget route2,
    required double largura,
    required double altura,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: altura * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _homePageCard(
            color: color,
            icon: icon,
            texto: title,
            context: context,
            route: route,
            largura: largura,
            altura: altura,
          ),
          _homePageCard(
            color: color2,
            icon: icon2,
            texto: title2,
            context: context,
            route: route2,
            largura: largura,
            altura: altura,
          ),
        ],
      ),
    );
  }

  InkWell _homePageCard({
    required Color color,
    required IconData icon,
    required String texto,
    required BuildContext context,
    required Widget route,
    required double largura,
    required double altura,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: largura * 0.48,
        width: altura * 0.22,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff040039).withOpacity(.13),
              blurRadius: 99,
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: _columnTextoIcon(
          largura: largura,
          altura: altura,
          color: color,
          icon: icon,
          texto: texto,
        ),
      ),
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context)
            .push(
              _myPageTransition.pageTransition(
                child: route,
                childCurrent: widget,
                buttoToTop: true,
              ),
            )
            .then(
              (value) => setState(() {}),
            );
      },
    );
  }

  Column _columnTextoIcon({
    required double largura,
    required double altura,
    required Color color,
    required IconData icon,
    required String texto,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(),
        _containerIcon(
          altura: altura,
          largura: largura,
          color: color,
          icon: icon,
        ),
        _textoCards(texto: texto),
        const SizedBox(),
      ],
    );
  }

  Container _containerIcon({
    required double largura,
    required double altura,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: altura * 0.10,
      width: largura * 0.13,
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color.withOpacity(.9),
      ),
    );
  }

  Text _textoCards({required String texto}) {
    return Text(
      texto,
      maxLines: 2,
      softWrap: true,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black.withOpacity(.7),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
