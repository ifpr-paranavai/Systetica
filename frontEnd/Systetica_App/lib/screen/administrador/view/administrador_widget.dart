import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/screen/administrador/view/administrador_page.dart';
import 'package:systetica/screen/ativar_funcionario/view/ativar_funcionario_page.dart';
import 'package:systetica/screen/empresa/view/empresa_page.dart';
import 'package:systetica/screen/produto/view/produto_page.dart';
import 'package:systetica/screen/servico/view/servico_page.dart';
import 'package:systetica/style/app_colors..dart';

class CadastroAdministradorWidget extends State<CadastroAdministradorPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  final _myPageTransition = MyPageTransition();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              infoGerais(widthSize: _width),
              grupoCards(
                title: "Empresa",
                icon: Icons.account_balance,
                color: AppColors.bluePrincipal,
                route: const EmpresaPage(),
                title2: 'Serviços',
                icon2: Icons.construction,
                color2: Colors.lightGreen,
                route2: const ServicoPage(),
                width: _width,
                context: context,
              ),
              grupoCards(
                title: "Produtos",
                icon: Icons.add_shopping_cart,
                color: AppColors.redPrincipal,
                route: const ProdutoPage(),
                title2: 'Ativar Funcionário',
                icon2: Icons.person,
                color2: Colors.black,
                route2: const AtivarFuncionarioPage(),
                width: _width,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding infoGerais({required double widthSize}) {
    return Padding(
      padding: EdgeInsets.only(
        left: widthSize / 17,
        right: widthSize / 15,
        top: widthSize / 18,
        bottom: widthSize / 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tituloSystetica(
            text: "Barbearia Systetica",
            fonteSize: 27,
            opacity: 0.6,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: widthSize / 35),
          tituloSystetica(
            text: "Bem vindo Franciel, aqui você poderá realizar seus "
                "cadastros e ativar seus funcionários.",
            fonteSize: 19,
            opacity: 0.5,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Text tituloSystetica({
    required String text,
    required double fonteSize,
    required double opacity,
    required FontWeight? fontWeight,
  }) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: fonteSize,
        color: Colors.black.withOpacity(opacity),
        fontWeight: fontWeight,
      ),
    );
  }

  Widget grupoCards({
    required Color color,
    required IconData icon,
    required String title,
    required Widget route,
    required Color color2,
    required IconData icon2,
    required String title2,
    required Widget route2,
    required double width,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: width / 17,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          homePageCard(
            color: color,
            icon: icon,
            texto: title,
            context: context,
            route: route,
            width: width,
          ),
          homePageCard(
            color: color2,
            icon: icon2,
            texto: title2,
            context: context,
            route: route2,
            width: width,
          ),
        ],
      ),
    );
  }

  Widget homePageCard({
    required Color color,
    required IconData icon,
    required String texto,
    required BuildContext context,
    required Widget route,
    required double width,
  }) {
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(15),
            height: width / 2.1,
            width: width / 2.4,
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
            child: columnTextoIcon(
              width: width,
              color: color,
              icon: icon,
              texto: texto,
            ),
          ),
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).push(
              _myPageTransition.pageTransition(
                child: route,
                childCurrent: widget,
                buttoToTop: true,
              ),
            );
          },
        ),
      ),
    );
  }

  Column columnTextoIcon({
    required double width,
    required Color color,
    required IconData icon,
    required String texto,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(),
        containerIcon(
          width: width,
          color: color,
          icon: icon,
        ),
        textoCards(texto: texto),
        const SizedBox(),
      ],
    );
  }

  Container containerIcon({
    required double width,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: width / 8,
      width: width / 8,
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

  Text textoCards({required String texto}) {
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
