import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:systetica/components/imagens_widget.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/loading/loading_animation.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/components/single_child_scroll_edicao.dart';
import 'package:systetica/components/text_autenticacoes_widget.dart';
import 'package:systetica/model/Info.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/screen/perfil/perfil_controller.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';
import 'package:systetica/style/app_colors..dart';

class PerfilWidget extends State<PerfilPage> {
  var myPageTransition = MyPageTransition();
  final PerfilController _controller = PerfilController();

  final List<Widget> items = [
    Row(
      children: const [
        Icon(
          Icons.edit,
          color: Colors.white,
          size: 22,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Editar",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
    Row(
      children: const [
        Icon(
          Icons.logout,
          color: Colors.white,
          size: 22,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Sair",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = (MediaQuery.of(context).size.height);
    double mediaQueryWidth = (MediaQuery.of(context).size.width);

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: dropDownButton(),
        body: FutureBuilder<Info?>(
          future: _controller.buscarUsuarioEmail(context),
          builder: (context, snapShot) {
            if (!snapShot.hasData) {
              return const LoadingAnimation();
            } else if (snapShot.hasData) {
              if (snapShot.data!.success!) {
                UsuarioDTO usuarioDTO = snapShot.data!.object;
                return SingleChildScrollEdicao(
                  widgetComponent: Center(
                    child: Column(
                      children: [
                        sizedBox(height: mediaQueryHeight * 0.08),
                        boxFoto(usuarioDTO.imagemBase64),
                        sizedBox(height: 50),
                        cardInfoUsuario(usuarioDTO: usuarioDTO),
                      ],
                    ),
                  ),
                );
              } else {
                return erroRequisicao(mediaQueryWidth);
              }
            } else {
              return erroRequisicao(mediaQueryWidth);
            }
          },
        ),
      ),
    );
  }

  DropdownButtonHideUnderline dropDownButton() {
    return DropdownButtonHideUnderline(
      child: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: DropdownButton2(
          customButton: const Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Icon(
              Icons.more_vert,
              size: 35,
              color: AppColors.redPrincipal,
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<Widget>(
                  value: item,
                  child: item,
                ),
              )
              .toList(),
          onChanged: (value) {},
          itemPadding: const EdgeInsets.all(15),
          dropdownWidth: 120,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.bluePrincipal,
          ),
          dropdownElevation: 8,
          offset: const Offset(-78, 2),
        ),
      ),
    );
  }

  SizedBox boxFoto(dynamic imagemUsuario) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black.withOpacity(0.6),
              spreadRadius: 2,
            )
          ],
        ),
        child: imgPerfil(imagemUsuario),
      ),
    );
  }

  Widget imgPerfil(dynamic image) {
    if (image == null || image == "") {
      return iconErroFoto();
    } else {
      image = base64Decode(image);
      if (image is Uint8List) {
        return circleAvatar(backgroundImage: MemoryImage(image));
      } else {
        return circleAvatar(backgroundImage: FileImage(image));
      }
    }
  }

  CircleAvatar circleAvatar({required ImageProvider backgroundImage}) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: backgroundImage,
    );
  }

  Padding cardInfoUsuario({required UsuarioDTO usuarioDTO}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            sizedBox(height: 5),
            itemNome(usuarioDTO.nome!),
            itemTelefone(usuarioDTO.telefone!),
            itemEmail(usuarioDTO.email!),
          ],
        ),
      ),
    );
  }

  ItemLista itemNome(String nome) {
    return ItemLista(
      titulo: "Nome completo",
      descricao: nome,
    );
  }

  ItemLista itemTelefone(String telefone) {
    return ItemLista(
      titulo: "Telefone",
      descricao: telefone,
    );
  }

  ItemLista itemEmail(String email) {
    return ItemLista(
      titulo: "E-mail",
      descricao: email,
    );
  }

  SizedBox sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // Widgets de erro
  Center erroRequisicao(double mediaQueryWidth) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagemErro(),
            textoErro(mediaQueryWidth),
          ],
        ),
      ),
    );
  }

  ImagensWidget imagemErro() {
    return ImagensWidget(
      paddingLeft: 0,
      image: "erro.png",
      widthImagem: 340,
    );
  }

  TextAutenticacoesWidget textoErro(double mediaQueryWidth) {
    return TextAutenticacoesWidget(
      paddingLeft: mediaQueryWidth * 0.12,
      text: "Oopss...ocorreu algum erro. \nTente novamente mais tarde.",
    );
  }

  Container iconErroFoto() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.redPrincipal,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
          )
        ],
      ),
      child: const Icon(
        Icons.person,
        size: 100,
        color: Colors.white,
      ),
    );
  }

}
