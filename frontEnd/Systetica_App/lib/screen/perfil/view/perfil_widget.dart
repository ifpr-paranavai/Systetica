import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/screen/perfil/perfil_controller.dart';
import 'package:systetica/screen/perfil/view/data.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:systetica/style/app_colors..dart';

class PerfilWidget extends State<PerfilPage> {
  var myPageTransition = MyPageTransition();
  final PerfilController _controller = PerfilController();
  UsuarioDTO data = getUsuarioData();
  dynamic _image;

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
    _image = base64Decode(data.imagemBase64!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: dropDownButton(),
        body: FutureBuilder<UsuarioDTO?>(
          future: _controller.buscarUsuarioEmail(context),
          builder: (context, snapShot) {
            if(!snapShot.hasData){
              return Text("Sem dados");
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: const Alignment(0.1, 0.05),
                    colors: [Colors.grey.withOpacity(0.4), Colors.white],
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boxFoto(),
                        sizedBox(height: 50),
                        cardInfoUsuario(),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        )
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
            child:  Icon(
              Icons.more_vert,
              size: 40,
              color: AppColors.redPrincipal,
            ),
          ),
          items: items.map((item) => DropdownMenuItem<Widget>(
            value: item,
            child: item,
          )).toList(),
          onChanged: (value) {},
          itemPadding: const EdgeInsets.all(15),
          dropdownWidth: 120,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.bluePrincipal,
          ),
          dropdownElevation: 8,
          offset: const Offset(-70, 0),
        ),
      ),
    );
  }

  SizedBox boxFoto() {
    return SizedBox(
      width: 195,
      height: 195,
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
        child: imgPerfil(),
      ),
    );
  }

  Widget imgPerfil() {
    if (_image == null) {
      return iconErroFoto();
    }
    if (_image is Uint8List) {
      return circleAvatar(backgroundImage: MemoryImage(_image));
    } else {
      return circleAvatar(backgroundImage: FileImage(_image));
    }
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

  CircleAvatar circleAvatar({required ImageProvider backgroundImage}) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: backgroundImage,
    );
  }

  Card cardInfoUsuario() {
    return Card(
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
          itemNome(),
          itemTelefone(),
          itemEmail(),
        ],
      ),
    );
  }

  Text textNome() {
    return textNomeTelefone(
      text: data.nome!,
      fonrSize: 23,
    );
  }

  Text textTelefone() {
    return textNomeTelefone(
      text: data.telefone!,
      fonrSize: 18,
    );
  }

  Text textNomeTelefone({required String text, required double fonrSize,}) {
    return Text(
      text,
      style: GoogleFonts.lora(
        fontSize: fonrSize,
        color: Colors.black,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  ItemLista itemNome() {
    return ItemLista(
      titulo: "Nome completo",
      descricao: data.nome!,
    );
  }

  ItemLista itemTelefone() {
    return ItemLista(
      titulo: "Telefone",
      descricao: data.telefone!,
    );
  }

  ItemLista itemEmail() {
    return ItemLista(
      titulo: "E-mail",
      descricao: data.email!,
    );
  }

  SizedBox sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
