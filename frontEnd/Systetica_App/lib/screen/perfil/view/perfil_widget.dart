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

class PerfilWidget extends State<PerfilPage> {
  var myPageTransition = MyPageTransition();
  final PerfilController _controller = PerfilController();
  UsuarioDTO data = getUsuarioData();
  dynamic _image;

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
        floatingActionButton: const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Icon(
            Icons.more_horiz,
            size: 25,
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0.1, 0.05),
                colors: [Colors.grey.withOpacity(0.4), Colors.white],
              ),
            ),
            child: Column(
              children: [
                sizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: 190,
                  height: 190,
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
                ),
                sizedBox(height: 50),
                Card(
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
                      itemCpf(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CircleAvatar imgPerfil() {
    if (_image is Uint8List) {
      return circleAvatar(backgroundImage: MemoryImage(_image));
    } else {
      return circleAvatar(backgroundImage: FileImage(_image));
    }
  }

  CircleAvatar circleAvatar({required ImageProvider backgroundImage}) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: backgroundImage,
    );
  }

  Text textNome() {
    return textNomeTelefone(
      text: data.nome!,
      fonrSize: 23,
    );
  }

  Text textTelefonePrincipal() {
    return textNomeTelefone(
      text: data.telefone!,
      fonrSize: 18,
    );
  }

  Text textNomeTelefone({
    required String text,
    required double fonrSize,
  }) {
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

  ItemLista itemCpf() {
    return ItemLista(
      titulo: "CPF",
      descricao: data.cpf!,
    );
  }

  SizedBox sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
