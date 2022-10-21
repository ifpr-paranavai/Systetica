import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


import '../../../components/alert_dialog_widget.dart';
import '../../../components/foto/foto_widget.dart';
import '../../../components/imagens_widget.dart';
import '../../../components/item_list.dart';
import '../../../components/loading/loading_animation.dart';
import '../../../components/single_child_scroll_component.dart';
import '../../../components/text_autenticacoes_widget.dart';
import '../../../database/repository/token_repository.dart';
import '../../../model/Info.dart';
import '../../../model/MenuItem.dart';
import '../../../model/Token.dart';
import '../../../model/Usuario.dart';
import '../../../style/app_colors.dart';
import '../../inicio/view/inicio_page.dart';
import '../perfil_controller.dart';
import 'form/perfil_form_page.dart';
import 'perfil_page.dart';

class PerfilWidget extends State<PerfilPage> {
  final PerfilController _controller = PerfilController();

  final List<MenuItemDto> _menuItems = [
    MenuItemDto(text: 'Editar', icon: Icons.edit),
    MenuItemDto(text: 'Sair', icon: Icons.close)
  ];

  @override
  void initState() {
    super.initState();
    _controller.usuario = Usuario();
  }

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    double _largura = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.branco,
        body: FutureBuilder<Info?>(
          future: _controller.buscarUsuarioEmail(context),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else if (snapShot.hasData && snapShot.data!.success!) {
              _controller.usuario = snapShot.data!.object;
              return NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return false;
                },
                child: Stack(
                  children: [
                    SingleChildScrollComponent(
                      widgetComponent: Center(
                        child: Column(
                          children: [
                            _sizedBox(height: _altura * 0.08),
                            FotoWidget().boxFoto(
                              imagemUsuario: _controller.usuario.imagemBase64,
                            ),
                            _sizedBox(height: _altura * 0.07),
                            _textoPerfil(),
                            _cardInfoUsuario(
                              usuario: _controller.usuario,
                            ),
                            _sizedBox(height: _altura * 0.05),
                          ],
                        ),
                      ),
                    ),
                    _dropDownButton(
                      usuario: _controller.usuario,
                      altura: _altura,
                    ),
                  ],
                ),
              );
            } else {
              return _erroRequisicao(_largura);
            }
          },
        ),
      ),
    );
  }

  DropdownButtonHideUnderline _dropDownButton({
    required Usuario usuario,
    required double altura,
  }) {
    return DropdownButtonHideUnderline(
      child: Container(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(top: altura * 0.02, right: 8),
          child: DropdownButton2(
            customButton: const Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Icon(
                Icons.more_vert,
                size: 35,
                color: AppColors.redPrincipal,
              ),
            ),
            itemPadding: const EdgeInsets.all(15),
            dropdownWidth: 105,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.bluePrincipal,
            ),
            dropdownElevation: 8,
            offset: const Offset(-65, 2),
            focusColor: Colors.transparent,
            items: _menuItems
                .map(
                  (item) => DropdownMenuItem<MenuItemDto>(
                    value: item,
                    child: MenuItemDto.buildItem(item),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == _menuItems.first) {
                Navigator.of(context)
                    .push(
                      _controller.myPageTransition.pageTransition(
                        child: PerfilFormPage(usuario: usuario),
                        childCurrent: widget,
                        buttoToTop: true,
                      ),
                    )
                    .then(
                      (value) => setState(() {}),
                    );
              } else {
                var alertDialog = AlertDialogWidget();
                alertDialog.alertDialog(
                  showModalOk: false,
                  context: context,
                  titulo: "Atenção!",
                  descricao: "Tem certeza que dejesa sair?",
                  onPressedNao: () => Navigator.pop(context),
                  onPressedOk: () async {
                    await TokenRepository.updateToken(
                      Token(id: 1),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      _controller.myPageTransition.pageTransition(
                        child: const InicioPage(),
                        childCurrent: widget,
                      ),
                      (route) => false,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  TextAutenticacoesWidget _textoPerfil() {
    return TextAutenticacoesWidget(
      text: "Perfil",
      fontSize: 30,
      paddingBottom: 6,
    );
  }

  Padding _cardInfoUsuario({required Usuario usuario}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 0.15,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _sizedBox(height: 5),
            _itemNome(usuario.nome!),
            _itemTelefone(usuario.telefone!),
            _itemEmail(usuario.email!),
          ],
        ),
      ),
    );
  }

  ItemLista _itemNome(String nome) {
    return ItemLista(
      titulo: "Nome",
      descricao: nome,
    );
  }

  ItemLista _itemTelefone(String telefone) {
    return ItemLista(
      titulo: "Telefone",
      descricao: telefone,
    );
  }

  ItemLista _itemEmail(String email) {
    return ItemLista(
      titulo: "E-mail",
      descricao: email,
    );
  }

  SizedBox _sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // Widgets de erro
  Center _erroRequisicao(double _largura) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagemErro(),
            _textoErro(_largura),
          ],
        ),
      ),
    );
  }

  ImagensWidget _imagemErro() {
    return ImagensWidget(
      paddingLeft: 0,
      image: "erro.png",
      widthImagem: 320,
    );
  }

  TextAutenticacoesWidget _textoErro(double _largura) {
    return TextAutenticacoesWidget(
      alignment: Alignment.center,
      paddingLeft: _largura * 0.15,
      paddingRight: _largura * 0.10,
      fontSize: 30,
      text: "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }
}
