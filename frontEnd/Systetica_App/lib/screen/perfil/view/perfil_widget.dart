import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:systetica/components/item_list.dart';
import 'package:systetica/components/page_transition.dart';
import 'package:systetica/model/UsuarioDTO.dart';
import 'package:systetica/screen/perfil/view/data.dart';
import 'package:systetica/screen/perfil/view/editar_perfil/editar_perfil_page.dart';
import 'package:systetica/screen/perfil/view/perfil_page.dart';

class PerfilWidget extends State<PerfilPage> {
  var myPageTransition = MyPageTransition();
  UsuarioDTO data = getUsuarioData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: const Alignment(0.2, 0.05),
                colors: [Colors.grey.withOpacity(0.19), Colors.white],
              ),
            ),
            child: Column(
              children: [
                sizedBox(),
                SizedBox(
                  width: 180,
                  height: 180,
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
                Column(
                  children: [
                    sizedBox(height: 10),
                    textNome(),
                    sizedBox(height: 8),
                    textTelefonePrincipal(),
                  ],
                ),
                sizedBox(height: 20),
                Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      sizedBox(height: 5),
                      itemEmail(),
                      itemCpf(),
                      itemDataNascimento(),
                      itemTelefone2(),
                      itemCidade(),
                      itemEstado(),
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

  ItemLista itemDataNascimento() {
    return ItemLista(
      titulo: "Data de Nascimento",
      descricao: data.dataNascimento!,
    );
  }

  ItemLista itemTelefone2() {
    return ItemLista(
      titulo: "Telefone 2",
      descricao: data.telefone2 ?? "Nenhum",
    );
  }

  ItemLista itemCidade() {
    return ItemLista(
      titulo: "Cidade",
      descricao: data.cidade!.nome,
    );
  }

  ItemLista itemEstado() {
    return ItemLista(
      titulo: "Estado",
      descricao: data.cidade!.estado!.nome + " - " + data.cidade!.estado!.uf,
    );
  }

  CircleAvatar imgPerfil() {
    return CircleAvatar(
      backgroundColor: Colors.black,
      backgroundImage: NetworkImage(
        "https://saobras.al.gov.br/cpl/img/login.png",
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 98, left: 98),
        child: SizedBox(
          width: 42,
          height: 42,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconSize: 20,
              color: Colors.black,
              icon: const Icon(
                Icons.edit,
              ),
              onPressed: () => Navigator.of(context)
                  .push(
                    myPageTransition.pageTransition(
                      child: const EditarPerfilPage(),
                      childCurrent: widget,
                      buttoToTop: true,
                    ),
                  )
                  .then(
                    (value) => setState(() {}),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Text textNome() {
    return textTitulo(
      text: data.nome!,
      fonrSize: 23,
    );
  }

  Text textTelefonePrincipal() {
    return textTitulo(
      text: data.telefone1!,
      fonrSize: 18,
    );
  }

  Text textTitulo({
    required String text,
    required double fonrSize,
  }) {
    return Text(
      text,
      style: GoogleFonts.lora(
        fontSize: fonrSize,
        color: Colors.black,
      ),
    );
  }

  SizedBox sizedBox({double? height = 40, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
