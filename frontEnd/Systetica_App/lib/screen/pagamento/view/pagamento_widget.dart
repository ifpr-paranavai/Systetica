import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systetica/screen/perfil/perfil_controller.dart';

import '../../../components/loading/loading_animation.dart';
import '../../../components/page_transition.dart';
import '../../../model/Info.dart';
import '../../../style/app_colors..dart';
import '../../pagamento_servico/view/servicos/servicos_page.dart';
import '../../servico/view/servico_page.dart';
import 'pagamento_page.dart';

class PagamentoWidget extends State<PagamentoPage>
    with SingleTickerProviderStateMixin {
  final PerfilController _perfilController = PerfilController();
  final _myPageTransition = MyPageTransition();

  late AnimationController _animationControllercontroller;
  double _largura = 0;
  double _altura = 0;

  @override
  void initState() {
    super.initState();

    _animationControllercontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _animationControllercontroller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationControllercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _largura = MediaQuery.of(context).size.width;
    _altura = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Info?>(
          future: _perfilController.buscarUsuarioEmail(context),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else {
              _perfilController.usuario = snapShot.data!.object;
              return body(
                altura: _altura,
                largura: _largura,
                nomeUsuario: _perfilController.usuario.nome!,
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
    required String nomeUsuario,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _infoGerais(
            titulo: "Olá " + nomeUsuario + "!",
            descricao: "Opções de pagamentos",
            widthSize: largura,
          ),
          SizedBox(
            height: altura * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _grupoCards(
                  title: "Serviços",
                  icon: Icons.account_balance,
                  color: AppColors.bluePrincipal,
                  route: const ServicosPage(),
                  title2: 'Produtos',
                  icon2: Icons.construction,
                  color2: Colors.lightGreen,
                  route2: const ServicoPage(),
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
        top: widthSize * 0.1,
        bottom: widthSize * 0.06,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tituloSystetica(
            fonteSize: 24,
            text: titulo,
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
