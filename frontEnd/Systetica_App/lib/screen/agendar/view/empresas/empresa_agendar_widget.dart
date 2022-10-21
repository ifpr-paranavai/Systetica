// import 'package:flutter/material.dart';
//
// import '../../../../components/erro/erro_widget.dart';
// import '../../../../components/foto/foto_widget.dart';
// import '../../../../components/list_view/list_view_foto_component.dart';
// import '../../../../components/loading/loading_animation.dart';
// import '../../../../model/Empresa.dart';
// import '../../../../model/Info.dart';
// import '../../../../model/Usuario.dart';
// import '../../../../style/app_colors.dart';
// import '../../../../utils/util.dart';
// import '../../../perfil/perfil_controller.dart';
// import '../../agendar_controller.dart';
// import '../detalhes_empresa/detalhes_empresa_page.dart';
// import 'empresa_agendar_page.dart';
//
// class EmpresaAgendarlWidget extends State<EmpresaAgendarPage> {
//   final AgendarController _controller = AgendarController();
//   final PerfilController _perfilController = PerfilController();
//   final ScrollController _scrollController = ScrollController();
//   Info? info = Info(success: true);
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _perfilController.usuario = Usuario();
//     buscarEmpresas();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double _altura = MediaQuery.of(context).size.height;
//     double _largura = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.branco,
//         body: loading
//             ? const LoadingAnimation()
//             : _body(
//                 largura: _largura,
//                 altura: _altura,
//                 empresas: _controller.empresas,
//                 usuario: _perfilController.usuario,
//               ),
//       ),
//     );
//   }
//
//   Future<void> buscarEmpresas() async {
//     await _perfilController
//         .buscarUsuarioEmail(context)
//         .then((value) => setState(() {
//               _perfilController.usuario = value!.object;
//             }));
//
//     await _controller.buscarEmpresas(context: context, nomeEmpresa: "").then(
//           (value) => setState(
//             () {
//               info = value;
//               _controller.empresas = value!.object;
//               loading = false;
//             },
//           ),
//         );
//   }
//
//   Widget _body({
//     required double altura,
//     required double largura,
//     required List<Empresa> empresas,
//     required Usuario usuario,
//   }) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             _infoGerais(
//               altura: altura,
//               largura: largura,
//               titulo: "Bem vindo" +
//                   (usuario.nome == null
//                       ? "!"
//                       : " " + Util.toSplitNome(usuario.nome!) + "!"),
//               widthSize: largura,
//             ),
//             Container(
//               padding: EdgeInsets.only(
//                 top: 15,
//                 right: largura * 0.060,
//               ),
//               width: largura * 0.40,
//               color: AppColors.branco,
//               alignment: Alignment.centerRight,
//               child: FotoWidget().boxFoto(
//                 imagemUsuario: usuario.imagemBase64,
//                 cirulo: 70,
//                 iconSizeErro: 50,
//               ),
//             ),
//           ],
//         ),
//         empresas.isEmpty
//             ? ErroWidget().erroRequisicao(
//                 largura: largura,
//                 listaVazia: true,
//                 altura: altura,
//                 nenhumItem: "Nenhuma empresa encontrada",
//               )
//             : _listView(
//                 altura: altura,
//                 largura: largura,
//                 empresas: empresas,
//               ),
//       ],
//     );
//   }
//
//   Widget _listView({
//     required double altura,
//     required double largura,
//     required List<Empresa> empresas,
//   }) {
//     return Expanded(
//       child: Container(
//         color: AppColors.branco,
//         child: ListView.builder(
//           controller: _scrollController,
//           shrinkWrap: true,
//           padding: EdgeInsets.only(
//             top: 30,
//             left: largura * 0.04,
//             right: largura * 0.04,
//           ),
//           physics: const BouncingScrollPhysics(
//             parent: AlwaysScrollableScrollPhysics(),
//           ),
//           itemCount: empresas.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListViewFotoOrNumeroComponent(
//               largura: largura,
//               altura: altura,
//               infoNome: empresas[index].nome!,
//               foto: empresas[index].logoBase64!,
//               onTap: () {
//                 Navigator.of(context)
//                     .push(
//                       _controller.myPageTransition.pageTransition(
//                         child: const DetalhaEmpresaPage(),
//                         childCurrent: widget,
//                         buttoToTop: true,
//                       ),
//                     )
//                     .then(
//                       (value) => setState(() {
//                         buscarEmpresas();
//                       }),
//                     );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Container _infoGerais({
//     required String titulo,
//     required double widthSize,
//     required double largura,
//     required double altura,
//   }) {
//     return Container(
//       height: 80,
//       width: largura * 0.60,
//       color: AppColors.branco,
//       alignment: Alignment.centerLeft,
//       padding: EdgeInsets.only(
//         left: widthSize * 0.07,
//         top: widthSize * 0.06,
//       ),
//       child: _tituloSystetica(
//         text: titulo,
//         opacity: 0.6,
//         fontWeight: FontWeight.w700,
//       ),
//     );
//   }
//
//   Text _tituloSystetica({
//     required String text,
//     required double opacity,
//     required FontWeight? fontWeight,
//   }) {
//     return Text(
//       text,
//       maxLines: 2,
//       overflow: TextOverflow.ellipsis,
//       style: TextStyle(
//         fontSize: 21,
//         color: Colors.black.withOpacity(opacity),
//         fontWeight: fontWeight,
//       ),
//     );
//   }
// }
